this.perk_legend_fashionable <- this.inherit("scripts/skills/skill", {
	m = {
		FreeSlotTypes = [
			this.Const.Items.ArmorUpgrades.Tabard,
			this.Const.Items.ArmorUpgrades.Cloak,
			this.Const.Items.HelmetUpgrades.Vanity
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFashionable);
	}

});
