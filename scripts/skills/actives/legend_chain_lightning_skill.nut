this.legend_chain_lightning_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ChainingTimes = 3, // this doesn't include the first initial hit
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

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendChainLightning);
		this.m.Description = "Unleash an arcing barrage that strikes an opponent, sending sparks from opponent to opponent.";
		this.m.KilledString = "Electrocuted";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/lightning", 4);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/electricity", 4);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.Delay = 300;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.HitChanceBonus = 10;
		this.m.DirectDamageMult = 0.8;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 50;
		this.m.MinRange = 2;
		this.m.MaxRange = 5;
		this.m.ChanceDecapitate = 5;
		this.m.ChanceDisembowel = 3;
		this.m.ChanceSmash = 0;
		this.m.MaxLevelDifference = 8;
		this.m.HeightReversed <- true;
	}

	function getTooltip() {
		local ret = getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=%damage%]" + m.MinBaseDamage + "[/color] - [color=%damage%]" + m.MaxBaseDamage + "[/color] damage that ignores armor"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Chance to hit is inversely affected by height"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chains to up to 3 more additional targets"
			}
		]);

		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithMagicStaff()) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used while wielding a magic staff[/color]"
			});
		} else if (::Tactical.isActive() && actor.isEngagedInMelee()) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot be used while engaged in melee[/color]"
			});
		}

		return ret;
	}

	function addResources() {
		foreach (r in m.SoundOnLightning) {
			::Tactical.addResource(r);
		}
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		return actor.isArmedWithMagicStaff() && (!::Tactical.isActive() || this.skill.isUsable() && !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()));
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.RangedSkill += (_targetEntity.getTile().Level - this.getContainer().getActor().getTile().Level) * 20;
			_properties.RangedAttackBlockedChanceMult *= 0.0;
		}
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		//		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		//		{
		//			this.m.FatigueCost -= 20;
		//			this.m.ActionPointCost -= 1;
		//		}
	}

	function onUse(_user, _targetTile) {
		for (local i = 0; i < ::Const.Tactical.LightningParticlesCaster.len(); ++i) {
			::Tactical.spawnParticleEffect(true, ::Const.Tactical.LightningParticlesCaster[i].Brushes, _user.getTile(), ::Const.Tactical.LightningParticlesCaster[i].Delay, ::Const.Tactical.LightningParticlesCaster[i].Quantity, ::Const.Tactical.LightningParticlesCaster[i].LifeTimeQuantity, ::Const.Tactical.LightningParticlesCaster[i].SpawnRate, ::Const.Tactical.LightningParticlesCaster[i].Stages);
		}
		this.m.TargetTile = _targetTile;
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer) {
			getContainer().setBusy(true);
			::Time.scheduleEvent(::TimeUnit.Virtual, this.m.Delay, onPerformAttack, {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled()) {
				_user.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return true;
		}

		return attackEntity(_user, _targetTile.getEntity());
	}

	function onPerformAttack(_tag) {
		for (local i = 0; i < ::Const.Tactical.LightningParticles.len(); ++i) {
			::Tactical.spawnParticleEffect(true, ::Const.Tactical.LightningParticles[i].Brushes, _tag.TargetTile, ::Const.Tactical.LightningParticles[i].Delay, ::Const.Tactical.LightningParticles[i].Quantity, ::Const.Tactical.LightningParticles[i].LifeTimeQuantity, ::Const.Tactical.LightningParticles[i].SpawnRate, ::Const.Tactical.LightningParticles[i].Stages);
		}

		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onBeforeTargetHit(_skill, _targetEntity, _hitInfo) {
		if (_skill == this) {
			_hitInfo.FatalityChanceMult = 0.0;
			_hitInfo.DamageRegular = ::Math.rand(m.MinBaseDamage, m.MaxBaseDamage);
			_hitInfo.DamageDirect = 1.0;
			_hitInfo.DamageArmor = 0.0;
		}
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill == this) {
			this.summonChainLighting(this.getContainer().getActor(), this.m.TargetTile);
		}
		this.m.TargetTile = null;
	}

	function onTargetMissed(_skill, _targetEntity) {
		this.m.TargetTile = null;
	}

	function onShieldHit(_info) {
		this.skill.onShieldHit(_info);

		if (_info.Skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChainLightning)) {
			_info.Skill.summonChainLighting(_info.User, _info.TargetEntity.getTile());
		}
	}

	function summonChainLighting(_user, _targetTile) {
		local target = null;
		local selectedTargets = [];
		local currentTargetTile = _targetTile;
		local myTile = _user.getTile();
		selectedTargets.push(currentTargetTile.ID);

		if (m.SoundOnLightning.len() != 0) {
			::Sound.play(::MSU.Array.rand(m.SoundOnLightning), ::Const.Sound.Volume.Skill * 2.0, _user.getPos());
		}

		for (local i = 0; i < m.ChainingTimes; i++) {
			local potentialTiles = searchTiles(currentTargetTile, myTile);
			local potentialTargets = searchTargets(_user, potentialTiles, selectedTargets);

			if (potentialTargets.len() != 0) {
				currentTargetTile = ::MSU.Array.rand(potentialTargets);
				selectedTargets.push(currentTargetTile.ID);
				target = currentTargetTile.getEntity();
			} else {
				target = null;
				currentTargetTile = ::MSU.Array.rand(potentialTiles);
			}

			applyEffect({
				Skill = this,
				User = _user,
				TargetTile = currentTargetTile,
				Target = target
			}, i * 150);
		}
	}

	function applyEffect(_data, _delay) {
		::Time.scheduleEvent(::TimeUnit.Virtual, _delay, function (_data) {
			for (local i = 0; i < ::Const.Tactical.LightningParticles.len(); ++i) {
				::Tactical.spawnParticleEffect(true, ::Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, ::Const.Tactical.LightningParticles[i].Delay, ::Const.Tactical.LightningParticles[i].Quantity, ::Const.Tactical.LightningParticles[i].LifeTimeQuantity, ::Const.Tactical.LightningParticles[i].SpawnRate, ::Const.Tactical.LightningParticles[i].Stages);
			}
		}, _data);

		if (::Legends.S.isNull(_data.Target)) {
			return;
		}

		::Time.scheduleEvent(::TimeUnit.Virtual, _delay, function (_data) {
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = ::Math.rand(m.MinBaseDamage, m.MaxBaseDamage);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_data.Target.onDamageReceived(_data.User, _data.Skill, hitInfo);
		}.bindenv(this), _data);
	}

	function searchTiles(_tile, _originTile) {
		return [0, 1, 2, 3, 4, 5].filter(@(_, _direction)(_tile.hasNextTile(_direction))).map(@(_direction)(_tile.getNextTile(_direction))).filter(@(_, _nextTile)(!_nextTile.isSameTileAs(_originTile)));
	}

	function searchTargets(_user, _tiles, _excluded) {
		return _tiles.filter(@(_, _tile)(_excluded.find(_tile.ID) == null) && _tile.IsOccupiedByActor && !::Legends.S.isEntityNullOrDead(_tile.getEntity()) && _tile.getEntity().isAttackable() && !_tile.getEntity().isAlliedWith(_user));
	}
});
