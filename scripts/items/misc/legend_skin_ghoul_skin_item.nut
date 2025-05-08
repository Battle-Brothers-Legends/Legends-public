this.legend_skin_ghoul_skin_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_skin_ghoul_skin";
		this.m.Name = "Ghoul Skin";
		this.m.Description = "This skin taken from a skin ghoul looks as if from a human, but covered in tears and stretch marks.";
		this.m.Icon = "misc/inventory_skin_ghoul_skin.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

