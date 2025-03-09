this.perk_legend_specialist_militia <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.militia_spear",
			"weapon.legend_wooden_spear",
			"weapon.ancient_spear"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Spear
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistMilitia);
		this.m.IconMini = "perk_spec_militia_mini.png";
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local tooltip = [];
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
		});

		if (!_isRanged)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(6, _item) + "[/color] Melee Defense"
			});
		}
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
			_properties.MeleeDefense += this.calculateSpecialistBonus(6, _skill.getItem());
		}
	}
});
