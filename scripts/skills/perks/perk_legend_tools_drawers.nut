this.perk_legend_tools_drawers <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 10,
		ToolEfficiencyModifier = 4
	},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendToolsDrawers);
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
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateArmorPartsModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateArmorPartsModifier();
	}

	function onUpdate( _properties )
	{
		_properties.Stamina += 3;
	}

});
