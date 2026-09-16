this.legend_skin_ghoul_skin_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_skin_ghoul_skin";
		this.m.Name = "Ghoul Skin";
		this.m.Description = "This skin taken from a skin ghoul looks as if from a human, but covered in tears and stretch marks.";
		this.m.Icon = "misc/inventory_skin_ghoul_skin.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

