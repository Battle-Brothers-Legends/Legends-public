this.legend_heartseeker_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsPolearm = false,
		IsTwoHanded = false
	},
	function create() {
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
		if (this.m.IsPolearm) {
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
			this.m.DirectDamageMult = 0.6;
		}
		if (this.m.IsTwoHanded) {
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
		}
	}

	function setItem(_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsPolearm) {
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
			this.m.DirectDamageMult = 0.5;
		}
		if (this.m.IsTwoHanded) {
			this.m.FatigueCost = 25;
			this.m.ActionPointCost = 7;
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local properties = this.getContainer().getActor().getCurrentProperties();
		if ((this.m.IsPolearm && !properties.IsSpecializedInPolearms) || (this.m.IsTwoHanded && !properties.IsSpecializedInSpears)) {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return ret;
	}

	function onAfterUpdate( _properties ) {
		if (this.m.IsPolearm) {
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 6 : 7;
			return;
		}
		else if (this.m.IsTwoHanded) {
			this.m.ActionPointCost = _properties.IsSpecializedInSpears ? 6 : 7;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInSpears ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.ThresholdToInflictInjuryMult *= 0.5;
			_properties.DamageTotalMult *= 1.1;
			if (_targetEntity == null)
				return;

			local actor = this.getContainer().getActor();
			if (actor.getTile().getDistanceTo(_targetEntity.getTile()) != 1)
				return;
			if ((this.m.IsPolearm && !_properties.IsSpecializedInPolearms) || (this.m.IsTwoHanded && !_properties.IsSpecializedInSpears)) {
				_properties.MeleeSkill -= 15;
				this.m.HitChanceBonus -= 15;
			}
		}
	}

});

