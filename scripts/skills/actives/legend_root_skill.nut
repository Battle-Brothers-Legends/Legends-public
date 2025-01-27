this.legend_root_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRoot);
		this.m.Description = "Unleash roots from the ground to ensnare your foes. Fatigue and AP costs reduced while raining and with staff mastery.";
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
		this.m.MaxLevelDifference = 4;
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

		if (this.getContainer().hasSkill("special.legend_rain"))
		{
		this.m.FatigueCost -= 10;
		this.m.ActionPointCost -= 1;
		}

	}

	function onUse( _user, _targetTile )
	{
		local targets = [];

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();

			if (this.isViableTarget(_user, entity))
			{
				targets.push(entity);
			}
		}

		foreach( target in targets )
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Rooted);
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.setDecal("roots_destroyed");
			breakFree.m.Icon = "skills/active_75.png";
			breakFree.m.IconDisabled = "skills/active_75_sw.png";
			breakFree.m.Overlay = "active_75";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			target.getSkills().add(breakFree);
			target.raiseRootsFromGround("bust_roots", "bust_roots_back");
		}

		if (targets.len() > 0 && this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, this.targetEntity.getPos());
		}

		return true;
	}

});

