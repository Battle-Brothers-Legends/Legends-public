this.perk_legend_specialist_cultist <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_cat_o_nine_tails"
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.Cultist
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistCultist);
		this.m.IconMini = "perk_spec_cultist_mini";
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
			icon = "ui/tooltips/chance_to_hit_head.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(15, _item) + "[/color] Chance to hit Head"
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
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (onAnySkillUsedSpecialistChecks(_skill))
			_properties.HitChance[this.Const.BodyPart.Head] += this.calculateSpecialistBonus(15, _skill.getItem());
	}
});
