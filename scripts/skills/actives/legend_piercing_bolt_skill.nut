this.legend_piercing_bolt_skill <- ::inherit("scripts/skills/actives/shoot_bolt", {
	m = {
		IsDoingPiercingShot = false,
		OriginalDirection = null
	},
	function create()
	{
		this.shoot_bolt.create();
		m.ID = "actives.legend_piercing_bolt";
		m.Name = "Piercing Bolt";
		m.Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them";
		m.KilledString = "Pierced";
		m.Icon = "skills/PiercingBoltSkill.png";
		m.IconDisabled = "skills/PiercingBoltSkill_bw.png";
		m.Overlay = "piercing_bolt";
		m.SoundOnHit = [
			"sounds/combat/split_hit_01.wav",
			"sounds/combat/split_hit_02.wav",
			"sounds/combat/split_hit_03.wav"
		];
		m.IsAOE = true;
		m.ActionPointCost = 4;
		m.FatigueCost = 10;
		m.ChanceDecapitate = 10;
		m.ChanceDisembowel = 50;
	}

	function getTooltip()
	{
		local find;
		local ret = this.shoot_bolt.getTooltip();

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
			text = "If the bolt hits its target, it will continue through and damage any target behind, dealing 50% damage."
		});

		return ret;
	}

	function isHidden()
	{
		return !getContainer().hasSkill("perk.legend_piercing_shot");
	}

	function onUse( _user, _targetTile )
	{
		m.OriginalDirection = _user.getTile().getDirectionTo(_targetTile);
		return shoot_bolt.onUse(_user, _targetTile);
	}

	function onScheduledTargetHit( _info )
	{
		// save this first lol
		local targetName = ::Const.UI.getColorizedEntityName(_info.TargetEntity), targetTile = _info.TargetEntity.getTile();
		// proceed as normal
		_info.Skill.shoot_bolt.onScheduledTargetHit(_info);

		if (_info.Skill.m.IsDoingPiercingShot || ::MSU.isNull(_info.User) || !_info.User.isAlive() || _info.User.isDying())
			return;

		local forwardTile = _info.Skill.getAffectedTiles(targetTile, _info.Skill.m.OriginalDirection);
		// show the effect
		_info.Skill.onSpawnPiercingEffect(targetTile, _info.Skill.m.OriginalDirection);

		if (forwardTile == null || !forwardTile.IsOccupiedByActor || !forwardTile.getEntity().isAttackable())
			return;

		// change these
		_info.Skill.m.IsUsingHitchance = false;
		_info.Skill.m.IsDoingPiercingShot = true;
		_info.Skill.m.IsShowingProjectile = false;

		if (targetTile.IsVisibleForPlayer)
			::Tactical.EventLog.logEx(format("%s pierces %s and hits %s", _info.Skill.getName(), targetName, ::Const.UI.getColorizedEntityName(forwardTile.getEntity())));

		_info.Skill.attackEntity(_info.User, forwardTile.getEntity(), false);

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
		local forwardTile = getAffectedTiles(_targetTile);
		::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);

		if (forwardTile == null)
			return;

		::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, forwardTile, forwardTile.Pos.X, forwardTile.Pos.Y);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.shoot_bolt.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this && m.IsDoingPiercingShot)
			_properties.RangedDamageMult *= 0.5;
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.reload_bolt");
	}

	function getAffectedTiles( _targetTile, _direction = null )
	{
		if (_direction == null)
			_direction = getContainer().getActor().getTile().getDirectionTo(_targetTile);

		if (!_targetTile.hasNextTile(_direction))
			return null;

		local forwardTile = _targetTile.getNextTile(_direction);
		local diff = _targetTile.Level - forwardTile.Level;

		if (diff < 0 || diff > 1)
			return null;

		return forwardTile;
	}

});
