this.perk_legend_specialist_poacher <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.wonky_bow",
			"weapon.short_bow"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Bow
		],
		ValidEntities = [
			this.Const.EntityType.Wolf,
			this.Const.EntityType.Hyena
		],
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistPoacher);
		this.m.IconMini = "perk_spec_shortbow_mini";
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
	// 		icon = "ui/icons/direct_damage.png",
	// 		text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.calculateSpecialistBonus(25, _item) + "%[/color] of any damage ignores armor"
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
			_properties.DamageDirectAdd += 0.01 * this.calculateSpecialistBonus(25, _skill.getItem());
	}
});
