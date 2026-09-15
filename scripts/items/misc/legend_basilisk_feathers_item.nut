this.legend_basilisk_feathers_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_basilisk_feathers";
		this.m.Name = "Basilisk Feathers";
		this.m.Description = "Feather-like scales of varying length and thickness. Closer to lamellar than downs.";
		this.m.Icon = "misc/inventory_basilisk_feathers.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 750;
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

