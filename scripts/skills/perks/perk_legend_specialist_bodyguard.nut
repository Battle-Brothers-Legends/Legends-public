this.perk_legend_specialist_bodyguard <- this.inherit("scripts/skills/skill", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_longsword",
			"weapon.legend_named_longsword",
			"weapon.longsword",
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.TwoHanded
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Sword
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistBodyguard);
		this.m.IconMini = "perk_spec_2hsword_mini.png";
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local tooltip = [];
		
		tooltip.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
		},
		{
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(20, _item) + "%[/color] Riposte Damage"
		},
		{
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(10, _item) + "%[/color] Area of Effect attacks"
		}]);
		if (::Legends.S.isCharacterWeaponSpecialized(properties, _item))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusDamage, _item) + "%[/color] Damage"
			});
		}
		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties)
		if (onAnySkillUsedSpecialistChecks(_skill))
		{
			if (_properties.IsRiposting)
			{
				_properties.DamageTotalMult *= 1.0 + 0.01 * this.calculateSpecialistBonus(20, _skill.getItem());
			}

			if (_skill.isAOE() && _skill.isAttack() && !_skill.isRanged())
			{
				_properties.DamageTotalMult *= 1 + 0.01 * this.calculateSpecialistBonus(10, _skill.getItem());
			}
		}
	}
});
