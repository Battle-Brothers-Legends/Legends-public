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
		ExcludedItemTypes = [
			this.Const.Items.ItemType.RangedWeapon
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistMilitia);
		this.m.IconMini = "perk_spec_militia_mini";
	}

	// function specialistWeaponTooltip (_item, _isRanged)
	// {
	// 	local properties = this.getContainer().getActor().getCurrentProperties();
	// 	local tooltip = [];

	// 	tooltip.push({
	// 		id = 7,
	// 		type = "text",
	// 		icon = "ui/icons/hitchance.png",
	// 		text = "[color=%positive%]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
	// 	});

	// 	if (!_isRanged)
	// 	{
	// 		tooltip.push({
	// 			id = 8,
	// 			type = "text",
	// 			icon = "ui/icons/melee_defense.png",
	// 			text = "[color=%positive%]+" + this.calculateSpecialistBonus(6, _item) + "[/color] Melee Defense"
	// 		});
	// 	}
	// 	if (::Legends.S.isCharacterWeaponSpecialized(properties, _item))
	// 	{
	// 		tooltip.push({
	// 			id = 7,
	// 			type = "text",
	// 			icon = "ui/icons/damage_dealt.png",
	// 			text = "[color=%positive%]+" + this.calculateSpecialistBonus(this.m.BonusDamage, _item) + "%[/color] Damage"
	// 		});
	// 	}
	// 	return tooltip;
	// }

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;
		if (this.onAnySkillUsedSpecialistChecks(_skill))
		{
			if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
			{
				_properties.DamageTotalMult *= 1.0 + 0.01 * this.calculateSpecialistBonus(15, _skill.getItem());
			}
		}
	}
});
