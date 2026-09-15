this.perk_legend_tools_spares <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 20,
		ToolEfficiencyModifier = 6
	},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendToolsSpares);
	}

	function getModifier()
	{
		return this.m.Amount;
	}

	function getToolEfficiencyModifier() {
		return this.m.ToolEfficiencyModifier;
	}

	function onAdded()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateArmorPartsModifier();
	}

	function onRemoved()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateArmorPartsModifier();
	}

	function onUpdate( _properties )
	{
		_properties.Stamina += 6;
	}

});
