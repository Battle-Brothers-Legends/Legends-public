this.legend_masterwork_metal <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_masterwork_metal";
		this.m.Name = "Masterwork Metal";
		this.m.Description = "Several ingots of unknown origin bearing the same mark. This metal dark yet surprisingly light in the hand. While not very useful alone, these could be used to create something with similar, rare materials.";
		this.m.Icon = "misc/legend_masterwork_metal.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1450;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

