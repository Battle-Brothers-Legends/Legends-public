this.legend_chain_lightning_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ChainingTimes =  3, // this doesn't include the first initial hit
		MinBaseDamage = 15,
		MaxBaseDamage = 40,
		SoundOnLightning = [
			"sounds/combat/dlc2/legendary_lightning_01.wav",
			"sounds/combat/dlc2/legendary_lightning_02.wav",
			"sounds/combat/electricity_01.wav",
			"sounds/combat/electricity_02.wav",
			"sounds/combat/electricity_03.wav",
			"sounds/combat/electricity_04.wav"
		],
		TargetTile = null
	},
	function create()
	{
		m.ID = "actives.legend_chain_lightning";
		m.Name = "Chain Lightning";
		m.Description = "Unleash an arcing barrage that strikes an opponent, sending sparks from opponent to opponent. Fatigue and action costs from staff mastery. ";
		m.KilledString = "Electrocuted";
		m.Icon = "skills/lightning_square.png";
		m.IconDisabled = "skills/lightning_square_bw.png";
		m.Overlay = "lightning_square";
		m.SoundOnUse = [
			"sounds/combat/lightning_01.wav",
			"sounds/combat/lightning_02.wav",
			"sounds/combat/lightning_03.wav",
			"sounds/combat/lightning_04.wav"
		];
		m.SoundOnHit = [
			"sounds/combat/electricity_01.wav",
			"sounds/combat/electricity_02.wav",
			"sounds/combat/electricity_03.wav",
			"sounds/combat/electricity_04.wav"
		];
		m.Type = ::Const.SkillType.Active;
		m.Order = ::Const.SkillOrder.OffensiveTargeted + 1;
		m.IsSerialized = false;
		m.IsActive = true;
		m.IsTargeted = true;
		m.IsStacking = false;
		m.IsAttack = true;
		m.IsRanged = true;
		m.IsIgnoredAsAOO = true;
		m.IsShowingProjectile = true;
		m.Delay = 1000;
		m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		m.HitChanceBonus = 10;
		m.DirectDamageMult = 0.8;
		m.ActionPointCost = 8;
		m.FatigueCost = 50;
		m.MinRange = 2;
		m.MaxRange = 5;
		m.ChanceDecapitate = 5;
		m.ChanceDisembowel = 3;
		m.ChanceSmash = 0;
		m.MaxLevelDifference = 8;
		m.ProjectileType = ::Const.ProjectileType.Missile;
	}

	function getTooltip()
	{
		local ret = getDefaultUtilityTooltip();

		local rangeBonus = ", more";
		if (m.MaxRangeBonus == 0)
			rangeBonus = " or";
		else if (m.MaxRangeBonus < 0)
			rangeBonus = ", less";

		ret.extend([
			{
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + m.MinBaseDamage + "[/color] - [color=" + ::Const.UI.Color.DamageValue + "]" + m.MaxBaseDamage + "[/color] damage that ignores armor"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + ::Const.UI.Color.PositiveValue + "]" + getMaxRange() + "[/color] tiles on even ground" + rangeBonus + " if shooting downhill"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chains up to 3 more additional targets"
			}
		]);

		if (!getContainer().getActor().isArmedWithMagicStaff())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]This character must be equipped with a magic staff[/color]"
			});
		}
		else if (::Tactical.isActive() && getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function addResources()
	{
		foreach( r in m.SoundOnLightning )
		{
			::Tactical.addResource(r);
		}
	}

	function isUsable()
	{
		if (!getContainer().getActor().isArmedWithMagicStaff())
			return false;

		return !::Tactical.isActive() || skill.isUsable() && !getContainer().getActor().getTile().hasZoneOfControlOtherThan(getContainer().getActor().getAlliedFactions());
	}

	function onAfterUpdate( _properties )
	{
		m.FatigueCostMult = _properties.IsSpecializedInStaves ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		// if (this.getContainer().hasSkill("special.legend_rain"))
		// {
		// m.FatigueCost -= 20;
		// m.ActionPointCost -= 1;
		// }
	}

	function onUse( _user, _targetTile )
	{
		this.m.TargetTile = _targetTile;
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			getContainer().setBusy(true);
			::Time.scheduleEvent(::TimeUnit.Virtual, m.Delay, onPerformAttack, {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
				_user.getTile().addVisibilityForFaction(::Const.Faction.Player);

			return true;
		}

		return attackEntity(_user, _targetTile.getEntity());
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this) {
			_hitInfo.FatalityChanceMult = 0.0;
			_hitInfo.DamageRegular = ::Math.rand(m.MinBaseDamage, m.MaxBaseDamage);
			_hitInfo.DamageDirect = 1.0;
			_hitInfo.DamageArmor = 0.0;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this) {
			this.summonChainLighting(this.getContainer().getActor(), this.m.TargetTile);
		}
		this.m.TargetTile = null;
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.TargetTile = null;
	}

	function onShieldHit( _info )
	{
		skill.onShieldHit(_info);

		if (_info.Skill.getID() == "actives.legend_chain_lightning")
			_info.Skill.summonChainLighting(_info.User, _info.TargetEntity.getTile());
	}

	function summonChainLighting( _user, _targetTile )
	{
		local target, selectedTargets = [];
		local currentTargetTile = _targetTile;
		local myTile = _user.getTile();
		selectedTargets.push(currentTargetTile.ID);

		if (m.SoundOnLightning.len() != 0)
			::Sound.play(::MSU.Array.rand(m.SoundOnLightning), ::Const.Sound.Volume.Skill * 2.0, _user.getPos());

		local potentialTiles, potentialTargets;

		for (local i = 0; i < m.ChainingTimes; ++i)
		{
			potentialTiles = searchTiles(currentTargetTile, myTile);
			potentialTargets = searchTargets(_user , potentialTiles, selectedTargets);

			if (potentialTargets.len() != 0) {
				currentTargetTile = ::MSU.Array.rand(potentialTargets);
				selectedTargets.push(currentTargetTile.ID);
				target = currentTargetTile.getEntity();
			}
			else {
				target = null;
				currentTargetTile = ::MSU.Array.rand(potentialTiles);
			}

			applyEffect({
				Skill = this,
				User = _user,
				TargetTile = currentTargetTile,
				Target = target
			}, i * 100 + 150);
		}
	}

	function applyEffect( _data, _delay )
	{
		::Time.scheduleEvent(::TimeUnit.Virtual, _delay, function ( _data ) {
			for( local i = 0; i < ::Const.Tactical.LightningParticles.len(); ++i )
			{
				this.Tactical.spawnParticleEffect(true, ::Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, ::Const.Tactical.LightningParticles[i].Delay, ::Const.Tactical.LightningParticles[i].Quantity, ::Const.Tactical.LightningParticles[i].LifeTimeQuantity, ::Const.Tactical.LightningParticles[i].SpawnRate, ::Const.Tactical.LightningParticles[i].Stages);
			}
		}, _data);

		if (::MSU.isNull(_data.Target))
			return;

		::Time.scheduleEvent(::TimeUnit.Virtual, _delay + 200, function ( _data ) {
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = ::Math.rand(m.MinBaseDamage, m.MaxBaseDamage);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_data.Target.onDamageReceived(_data.User, _data.Skill, hitInfo);
		}.bindenv(this), _data);
	}

	function searchTiles( _tile, _originTile )
	{
		local ret = [];
		for( local i = 0; i < 6; i++ )
		{
			if (!_tile.hasNextTile(i))
				continue;
			local tile = _tile.getNextTile(i);
			if (!_originTile.isSameTileAs(tile))
				ret.push(tile);
		}
		return ret;
	}

	function searchTargets( _user , _tiles , _excluded )
	{
		local ret = [];
		foreach( tile in _tiles )
		{
			if (_excluded.find(tile.ID) != null)
				continue;
			if (!tile.IsOccupiedByActor)
				continue;
			if (!tile.getEntity().isAlive() && tile.getEntity().isDying())
				continue;
			if (!tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user))
				continue;
			ret.push(tile);
		}
		return ret;
	}

});

