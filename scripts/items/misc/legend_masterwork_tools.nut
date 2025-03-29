this.legend_masterwork_tools <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_masterwork_tools";
		this.m.Name = "Masterwork Tools";
		this.m.Description = "An assortment of tools in varying size, shape and function. Each tool bears a unique mark that lingers in the back of your mind. These tools are specially made and could be used to create something with rare materials.";
		this.m.Icon = "misc/legend_masterwork_tools.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 750;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

