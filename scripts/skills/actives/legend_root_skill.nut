this.legend_root_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRoot);
		this.m.Description = "Unleash roots from the ground to ensnare your target to prevent them from moving or defending themself effectively. Will always hit if the enemy isn\'t immune. This spell is easier to cast when it\'s raining.";
		this.m.Icon = "skills/roots_square.png";
		this.m.IconDisabled = "skills/roots_square_bw.png";
		this.m.Overlay = "active_70";
		this.m.SoundOnUse = [
			"sounds/enemies/goblin_roots_01.wav",
			"sounds/enemies/goblin_roots_02.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 8;
	}

	function getTooltip()
	{
		local tooltip = this.getDefaultUtilityTooltip();

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	function isViableTarget( _user, _target )
	{
		if (_target.isAlliedWith(_user))
		{
			return false;
		}

		if (_target.getCurrentProperties().IsRooted)
		{
			return false;
		}

		if (_target.getCurrentProperties().IsImmuneToRoot)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		{
		this.m.FatigueCost -= 10;
		this.m.ActionPointCost -= 1;
		}

	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.isViableTarget(_user, target))
		{
			local item = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local hasStaff = item != null && item.getID() == "legend_named_goblin_staff";
			if (!hasStaff)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Rooted);
			}
			else
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Rooted, function(_effect) {
					_effect.setDamage(10, 20);
				}.bindenv(this));
			}
			::Legends.Actives.grant(target, ::Legends.Active.BreakFree, function (_skill) {
				_skill.setDecal("roots_destroyed");
				_skill.m.Icon = "skills/active_75.png";
				_skill.m.IconDisabled = "skills/active_75_sw.png";
				_skill.m.Overlay = "active_75";
				_skill.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			}.bindenv(this));
			target.raiseRootsFromGround("bust_roots", "bust_roots_back");

			this.Sound.play(this.m.SoundOnHitHitpoints[this.Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
		}

		return true;
	}

});

