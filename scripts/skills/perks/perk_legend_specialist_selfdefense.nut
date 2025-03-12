this.perk_legend_specialist_selfdefense <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_staff",
			"weapon.legend_tipstaff",
			"weapon.legend_staff_vala",
			"weapon.legend_staff_gnarled"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Staff
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistSelfdefense);
		this.m.IconMini = "perk_spec_staff_mini.png";
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Staves and Musical Instruments");
	}

	// function specialistWeaponTooltip (_item, _isRanged)
	// {
	// 	local properties = this.getContainer().getActor().getCurrentProperties();
	// 	local tooltip = [];

	// 	tooltip.push({
	// 		id = 7,
	// 		type = "text",
	// 		icon = "ui/icons/hitchance.png",
	// 		text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
	// 	});
	// 	tooltip.push({
	// 		id = 6,
	// 		type = "text",
	// 		icon = "ui/icons/melee_defense.png",
	// 		text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(16, _item) + "[/color] Defense"
	// 	});

	// 	if (::Legends.S.isCharacterWeaponSpecialized(properties, _item))
	// 	{
	// 		tooltip.push({
	// 			id = 7,
	// 			type = "text",
	// 			icon = "ui/icons/damage_dealt.png",
	// 			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusDamage, _item) + "%[/color] Damage"
	// 		});
	// 	}
	// 	return tooltip;
	// }

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (onAnySkillUsedSpecialistChecks(_skill))
		{
			_properties.MeleeDefense += this.calculateSpecialistBonus(16, _skill.getItem());
			_properties.RangedDefense += this.calculateSpecialistBonus(16, _skill.getItem());
		}
	}
});
