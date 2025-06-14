this.perk_legend_fashionable <- this.inherit("scripts/skills/skill", {
	m = {
		FreeSlotTypes = [
			this.Const.Items.ArmorUpgrades.Tabbard,
			this.Const.Items.ArmorUpgrades.Cloak,
			this.Const.Items.HelmetUpgrades.Vanity
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFashionable);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});
