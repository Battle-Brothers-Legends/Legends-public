this.perk_legend_net_repair <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNetRepair);
	}

	function onAdded()
	{
		getContainer().getActor().getFlags().set("LegendsCanRepairNet", true);
	}

	function onRemoved()
	{
		getContainer().getActor().getFlags().remove("LegendsCanRepairNet");
	}

	function onUpdate( _properties )
	{
		local item = getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Net))
			_properties.MeleeDefense += 10;
	}

});
