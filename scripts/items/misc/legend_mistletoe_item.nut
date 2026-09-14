this.legend_mistletoe_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_mistletoe";
		this.m.Name = "Mistletoe";
		this.m.Description = "This parasitic plant attaches itself to a host tree. It is known associated with fertility, and used in mystical ceremonies";
		this.m.Icon = "misc/inventory_mistletoe.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 50;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

