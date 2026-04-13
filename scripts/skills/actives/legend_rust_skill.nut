this.legend_rust_skill <- this.inherit("scripts/skills/legend_magic_skill", {
	m = {},
	function create()
	{
		this.legend_magic_skill.create();
		this.m.AdditionalAccuracy = 10;
		this.m.DamageInitiativeMin = 15;
		this.m.DamageInitiativeMax = 45;
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRust);
		this.m.Description = "Tarnish leather and metal with rapid age, thereby undermining the solidity of the armor worn by your target. Damaged done is based off current initiative.\nHitchcance is determined by Ranged Skill.";
		this.m.Icon = "skills/rust56.png";
		this.m.IconDisabled = "skills/rust56_bw.png";
		this.m.Overlay = "rust";
		this.m.SoundOnUse = [
			"sounds/combat/crush_armor_01.wav",
			"sounds/combat/crush_armor_02.wav",
			"sounds/combat/crush_armor_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/crush_armor_hit_01.wav",
			"sounds/combat/crush_armor_hit_02.wav",
			"sounds/combat/crush_armor_hit_03.wav"
		];
		this.m.SoundVolume = 1.1;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsTooCloseShown = true;
		this.m.DirectDamageMult = 0.0;
		this.m.HitChanceBonus = 0;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local damage_armor_min = this.Math.floor(p.getInitiativeMinDamage());
		local damage_armor_max = this.Math.floor(p.getInitiativeMaxDamage());
		local ret = this.getDefaultUtilityTooltip();

			ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "Inflicts [color=%damage%]" + damage_armor_min + "[/color] - [color=%damage%]" + damage_armor_max + "[/color] damage to armor"
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]" + 10 + "[/color] damage to hitpoints that ignores armor"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]3[/color] tiles"
		});

		// if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		// {
		// 	ret.push({
		// 		id = 6,
		// 		type = "text",
		// 		icon = "ui/icons/hitchance.png",
		// 		text = "Has [color=%negative%]-15%[/color] chance to spread and hit targets directly adjacent because of the corrosive nature of the spell"
		// 	});
		// }

		return ret;
	}

	function getExpectedDamage( _target )
	{
		local ret = this.skill.getExpectedDamage(_target);
		ret.HitpointDamage = this.Math.max(10, ret.HitpointDamage);
		ret.TotalDamage = this.Math.max(10, ret.TotalDamage);
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		return this.attackEntity(_user, target);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_magic_skill.onAnySkillUsed(_skill, _targetEntity, _properties );
		if (_skill == this)
		{
			_properties.DamageMinimum = 10;
			_properties.DamageArmorMult = 1.0;
			_properties.DamageTotalMult = 1.0;
		}
	}

});
