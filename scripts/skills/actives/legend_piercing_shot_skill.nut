this.legend_piercing_shot_skill <- ::inherit("scripts/skills/actives/aimed_shot", {
	m = {
		IsDoingPiercingShot = false,
		OriginalDirection = null
	},
	function create()
	{
		this.aimed_shot.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPiercingShot);
		this.m.Description = "A shot with so much force that it passes straight through the target to whoever is behind them.";
		this.m.KilledString = "Pierced";
		this.m.Icon = "skills/PiercingBoltSkill.png";
		this.m.IconDisabled = "skills/PiercingBoltSkill_bw.png";
		this.m.Overlay = "piercing_bolt";
		this.m.SoundOnHit = [
			"sounds/combat/split_hit_01.wav",
			"sounds/combat/split_hit_02.wav",
			"sounds/combat/split_hit_03.wav"
		];
		this.m.IsAOE = true;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 5;
		this.m.ChanceDecapitate = 5;
		this.m.ChanceDisembowel = 25;
		this.m.AdditionalAccuracy = 0;
		this.m.AdditionalHitChance = -4;
	}

	function getTooltip()
	{
		local find;
		local ret = this.aimed_shot.getTooltip();

		for (local i = ret.len() - 1; i >= 0; --i)
		{
			if (ret[i].id != 8)
				continue;

			find = i; // find where the ammo tooltip to insert before it
			break;
		}

		if (find == null)
			return ret;

		ret.insert(find, {
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the arrow hits its target, it will continue through and damage any target behind, dealing 50% damage."
		});

		return ret;
	}

	function isHidden()
	{
		return !getContainer().hasPerk(::Legends.Perk.LegendPiercingShot);
	}

	function onAfterUpdate( _properties )
	{
		this.aimed_shot.onAfterUpdate(_properties);
		m.AdditionalAccuracy = m.Item.getAdditionalAccuracy();
		local bonusRange = (_properties.IsSpecializedInBows ? 1 : 0) + (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSharpshooter) ? 1 : 0);
		this.m.MaxRange = this.m.Item.getRangeMax() + bonusRange;
	}

	function onUse( _user, _targetTile )
	{
		m.OriginalDirection = _user.getTile().getDirectionTo(_targetTile);
		return aimed_shot.onUse(_user, _targetTile);
	}

	function onScheduledTargetHit( _info )
	{
		// save this first lol
		local targetName = ::Const.UI.getColorizedEntityName(_info.TargetEntity), targetTile = _info.TargetEntity.getTile();
		// proceed as normal
		_info.Skill.aimed_shot.onScheduledTargetHit(_info);

		if (_info.Skill.m.IsDoingPiercingShot || ::MSU.isNull(_info.User) || !_info.User.isAlive() || _info.User.isDying())
			return;

		local forwardTile = _info.Skill.getAffectedTiles(targetTile, _info.Skill.m.OriginalDirection);
		// show the effect
		_info.Skill.onSpawnPiercingEffect(targetTile, _info.Skill.m.OriginalDirection);

		if (forwardTile.len() == 0) return;
		else forwardTile = forwardTile[0];

		if (!forwardTile.IsOccupiedByActor || !forwardTile.getEntity().isAttackable())
			return;

		// change these
		_info.Skill.m.IsUsingHitchance = false;
		_info.Skill.m.IsDoingPiercingShot = true;
		_info.Skill.m.IsShowingProjectile = false;

		if (::Legends.Traits.has(forwardTile.getEntity(), ::Legends.Trait.RacialGhost))
		{
			if (targetTile.IsVisibleForPlayer)
				::Tactical.EventLog.logEx(format("%s pierces %s but %s\'s corporeal form is unscathed", _info.Skill.getName(), targetName, ::Const.UI.getColorizedEntityName(forwardTile.getEntity())));	
		}
		else
		{
			if (targetTile.IsVisibleForPlayer)
				::Tactical.EventLog.logEx(format("%s pierces %s and hits %s", _info.Skill.getName(), targetName, ::Const.UI.getColorizedEntityName(forwardTile.getEntity())));

			_info.Skill.attackEntity(_info.User, forwardTile.getEntity(), false);
		}

		// reset back to normal lol
		_info.Skill.m.IsUsingHitchance = true;
		_info.Skill.m.IsDoingPiercingShot = false;
		_info.Skill.m.IsShowingProjectile = true;
	}

	// to properly display the piercing effect
	function onSpawnPiercingEffect( _targetTile, _direction )
	{
		if (!_targetTile.IsVisibleForPlayer)
			return;

		if (::Tactical.getCamera().IsFlipped)
		{
			_direction = _direction + 3;

			if (_direction >= ::Const.Direction.COUNT)
				_direction = _direction - ::Const.Direction.COUNT;
		}

		if (::Const.Tactical.AttackEffectSplit[_direction].Brush.len() == 0)
			return;

		local secondMovementDelay = (::Const.Tactical.Settings.AttackEffectFadeInDuration + ::Const.Tactical.Settings.AttackEffectStayDuration + ::Const.Tactical.Settings.AttackEffectFadeOutDuration) / 2;
		::Tactical.spawnAttackEffect(::Const.Tactical.AttackEffectSplit[_direction].Brush, _targetTile, ::Const.Tactical.AttackEffectSplit[_direction].Offset.X + ::Const.Tactical.Settings.AttackEffectOffsetX, ::Const.Tactical.AttackEffectSplit[_direction].Offset.Y + ::Const.Tactical.Settings.AttackEffectOffsetY, ::Const.Tactical.Settings.AttackEffectFadeInDuration, ::Const.Tactical.Settings.AttackEffectStayDuration, ::Const.Tactical.Settings.AttackEffectFadeOutDuration, ::Const.Tactical.AttackEffectSplit[_direction].Movement0, secondMovementDelay, ::Const.Tactical.AttackEffectSplit[_direction].Movement1, false);
	}

	function onTargetSelected( _targetTile )
	{
		this.skill.onTargetSelected(_targetTile);

		local forwardTile = getAffectedTiles(_targetTile);
		if (forwardTile.len() == 0)
			return;

		::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, forwardTile[0], forwardTile[0].Pos.X, forwardTile[0].Pos.Y);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.aimed_shot.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this && m.IsDoingPiercingShot)
			_properties.RangedDamageMult *= 0.5;
	}

	function getAffectedTiles( _targetTile, _direction = null )
	{
		if (_direction == null)
			_direction = getContainer().getActor().getTile().getDirectionTo(_targetTile);

		if (!_targetTile.hasNextTile(_direction))
			return [];

		local forwardTile = _targetTile.getNextTile(_direction);
		local diff = _targetTile.Level - forwardTile.Level;

		if (diff < 0 || diff > 1)
			return [];

		return [forwardTile];
	}

});
