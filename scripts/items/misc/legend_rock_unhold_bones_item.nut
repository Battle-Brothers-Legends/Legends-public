this.legend_rock_unhold_bones_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_rock_unhold_bones";
		this.m.Name = "Rock Unhold Bones";
		this.m.Description = "These large bones taken from a Rock Unhold are incredibly strong and valuable";
		this.m.Icon = "misc/inventory_rock_unhold_bones.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 4000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

