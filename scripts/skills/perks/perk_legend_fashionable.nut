this.perk_legend_fashionable <- this.inherit("scripts/skills/skill", {
	m = {
		FreeSlotTypes = [
			::Const.Items.ArmorUpgrades.Tabard,
			::Const.Items.ArmorUpgrades.Cloak,
			::Const.Items.HelmetUpgrades.Vanity
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFashionable);
	}

});
