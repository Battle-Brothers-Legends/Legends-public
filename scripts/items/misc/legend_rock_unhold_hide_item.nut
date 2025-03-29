this.legend_rock_unhold_hide_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_rock_unhold_hide";
		this.m.Name = "Rock Unhold Hide";
		this.m.Description = "The thick hide of an unhold mixes the best properties of hide and rock, pliable but nearly industructible";
		this.m.Icon = "misc/inventory_rock_unhold_hide.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 3500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

