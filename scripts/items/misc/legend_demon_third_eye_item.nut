this.legend_demon_third_eye_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_demon_third_eye";
		this.m.Name = "Third Demon Eye";
		this.m.Description = "Demon alps have no eyes, yet this eye-like organ can be retreived from inside their skulls.";
		this.m.Icon = "misc/inventory_demonalp_eye.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 7500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

