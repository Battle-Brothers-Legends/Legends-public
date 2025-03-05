this.perk_legend_specialist_miner <- this.inherit("scripts/skills/skill", {
	m = {
		SpecialistWeaponIds = [
			"weapon.pickaxe",
			"weapon.military_pick"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Hammer
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.TwoHanded
		],
		ValidEntities = [
			this.Const.EntityType.LegendRockUnhold,
			this.Const.EntityType.SandGolem
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistMiner);
		this.m.IconMini = "perk_spec_pickaxe_mini.png";
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
