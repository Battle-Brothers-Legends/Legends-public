this.perk_legend_specialist_shepherd <- this.inherit("scripts/skills/skill", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_sling",
			"weapon.legend_slingshot"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Sling
		],
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistShepherd);
		this.m.IconMini = "perk_spec_sling_mini.png";
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
			icon = "ui/icons/armor_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(25, _item) + "[/color] Chance to hit Head"
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
			_properties.DamageArmorMult += 0.01 * this.calculateSpecialistBonus(25, _skill.getItem());
	}
});
