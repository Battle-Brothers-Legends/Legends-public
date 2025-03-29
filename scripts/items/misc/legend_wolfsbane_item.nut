this.legend_wolfsbane_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_wolfsbane";
		this.m.Name = "Wolfsbane";
		this.m.Description = "This perenial species of poisonous flower typically grows in mountain meadows. Can be used to craft things with great effect on were creatures.";
		this.m.Icon = "misc/inventory_wolfsbane.png";
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

