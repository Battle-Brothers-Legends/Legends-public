this.legend_basilisk_eye_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_basilisk_eye";
		this.m.Name = "Fowl Eye";
		this.m.Description = "The unfaltering, cruel gaze of a Basilisk. Even now it's giving you goosebumps.";
		this.m.Icon = "misc/inventory_basilisk_eye.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

	function getSellPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}

});

