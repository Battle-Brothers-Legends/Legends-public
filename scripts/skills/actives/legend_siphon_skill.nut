this.legend_siphon_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSiphon);
		this.m.Description = "Siphon the life force from your foe to yourself - replenishing your health and diminishing theirs.\n\nIt will never kill your victim and you can\'t draw more health than you are missing. Damage drops off over distance and uses Melee Skill to hit.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/siphon_square.png";
		this.m.IconDisabled = "skills/siphon_square_bw.png";
		this.m.Overlay = "siphon_square";
		this.m.SoundOnUse = [
			"sounds/combat/drain_01.wav",
			"sounds/combat/drain_02.wav",
			"sounds/combat/drain_03.wav",
			"sounds/combat/drain_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 5;
	}


	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/health.png", // fix from /ui to ui/, Abyss 6/17/23
				text = "Siphons up to [color=%damage%]30%[/color] of targets health to you. Drops by [color=%negative%]5%[/color] for each tile distance."
			}
		];
	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		if (_targetTile.IsEmpty)
		{
			return false
		}

		if (!_targetTile.getEntity().isAttackable() || !_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying())
		{
			return false;
		}

		if (_targetTile.getEntity().getFlags().has("IsSummoned"))
		{
			return false;
		}

		if (!this.m.IsRanged && this.m.IsVisibleTileNeeded && this.getMaxRange() > 1 && _originTile.getDistanceTo(_targetTile) > 1)
		{
			local myPos = _originTile.Pos;
			local targetPos = _targetTile.Pos;
			local Dx = (targetPos.X - myPos.X) / 2;
			local Dy = (targetPos.Y - myPos.Y) / 2;
			local x = myPos.X + Dx;
			local y = myPos.Y + Dy;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);

			if (tile.Level > _originTile.Level && (_originTile.Level - tile.Level < -1 || _targetTile.Level - tile.Level < -1))
			{
				return false;
			}
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill != this)
		{
			return
		}

		local actor = this.getContainer().getActor();
		local distance = _targetEntity.getTile().getDistanceTo(actor.getTile());
		local max = actor.getHitpointsMax() - actor.getHitpoints();

		local p = 0.3 - (0.05 * (distance - 1));
		local damage = this.Math.min(max, p * _targetEntity.getHitpoints());

		_properties.DamageArmorMult *= 0.0;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.DamageRegularMin = damage;
		_properties.DamageRegularMax = damage;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
		{
			return;
		}
		local actor = this.getContainer().getActor();
		local maxHP = actor.getHitpointsMax();
		actor.setHitpoints(this.Math.min(actor.getHitpoints() + _damageInflictedHitpoints, maxHP));
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});
