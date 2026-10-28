this.legend_cull_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCull);
		this.m.Description = "A heavy axe to the back when your enemy's morale is broken and they're at their most vulnerable.";
		this.m.KilledString = "Culled";
		this.m.SoundOnUse = [
			"sounds/combat/chop_01.wav",
			"sounds/combat/chop_02.wav",
			"sounds/combat/chop_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 100;
		this.m.ChanceDisembowel = 25;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]20%[/color] extra damage done against enemies that are [color=%status%]Wavering[/color] and [color=%positive%]30%[/color] extra damage done against enemies that are [color=%status%]Fleeing[/color]"
		},
		{
			id = 8,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=%positive%]+10%[/color] of any damage ignores armor against enemies that are [color=%status%]Wavering[/color] and [color=%positive%]20%[/color] of any damage ignores armor against enemies that are [color=%status%]Fleeing[/color]"
		},
		{
			id = 9,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%positive%]+10%[/color] chance to hit against enemies that are [color=%status%]Wavering[/color] and [color=%positive%]20%[/color] chance to hit against enemies that are [color=%status%]Fleeing[/color]"
		}]);
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill != this) {
			return;	
		}
		if (_targetEntity == null) {
			return;
		}
		if (_targetEntity.getMoraleState() == ::Const.MoraleState.Wavering) {
			_properties.DamageTotalMult *= 1.2;
			_properties.DamageDirectAdd += 0.1;
			this.m.HitChanceBonus += 10;
			_properties.MeleeSkill += 10;
		}
		if (_targetEntity.getMoraleState() == ::Const.MoraleState.Fleeing) {
			_properties.DamageTotalMult *= 1.3;
			_properties.DamageDirectAdd += 0.2;
			this.m.HitChanceBonus += 20;
			_properties.MeleeSkill += 20;
		}
	}

});

