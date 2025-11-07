this.legend_heartseeker_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsPolearm = false,
		IsTwoHanded = false
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHeartseeker);
		this.m.Description = "Put your full weight in a thrust, targetting the enemy\'s weakpoints and inflicting terrible injuries.";
		this.m.KilledString = "Pierced";
		this.m.Icon = "skills/active_legend_heartseeker.png";
		this.m.IconDisabled = "skills/active_legend_heartseeker_bw.png";
		this.m.Overlay = "active_legend_heartseeker";
		this.m.SoundOnUse = [
			"sounds/combat/impale_01.wav",
			"sounds/combat/impale_02.wav",
			"sounds/combat/impale_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/impale_hit_01.wav",
			"sounds/combat/impale_hit_02.wav",
			"sounds/combat/impale_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.55;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
		if (this.m.IsPolearm)
		{
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
			this.m.DirectDamageMult = 0.6;
		}
		if (this.m.IsTwoHanded)
		{
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
		}
	}

	function setItem(_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsPolearm)
		{
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
			this.m.DirectDamageMult = 0.5;
		}
		if (this.m.IsTwoHanded)
		{
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		return ret;
	}
	
	function onAfterUpdate( _properties )
	{
		if (this.m.IsPolearm)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 6 : 7;
			return;
		}
		else if (this.m.IsTwoHanded)
		{
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 6 : 7;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInSpears ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.ThresholdToInflictInjuryMult *= 0.5;
		}
	}

});

