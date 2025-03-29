this.perk_legend_net_repair <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendNetRepair);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
		local item = getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Net))
			_properties.MeleeDefense += 10;
	}

});
