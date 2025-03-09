this.perk_legend_specialist_inquisition <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_wooden_stake",
			"weapon.legend_hand_crossbow",
			"weapon.goblin_crossbow"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Crossbow
		],
		ValidEntities = [
			this.Const.EntityType.Hexe,
			this.Const.EntityType.Alp
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistInquisition);
		this.m.IconMini = "perk_spec_xbow_mini.png";
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local tooltip = [];
		
		// both are the same chance so i didn't bother separating them
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
		});

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.calculateSpecialistBonus(25, _item) + "%[/color] of any damage ignores armor"
		});

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
});
