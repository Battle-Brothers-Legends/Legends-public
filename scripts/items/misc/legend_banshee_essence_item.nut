this.legend_banshee_essence_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_banshee_essence";
		this.m.Name = "Banshee Essence";
		this.m.Description = "The remaining residue of a dissipated Winselmutter. if you listen closely you can still hear her sobbing from the jar.";
		this.m.Icon = "misc/inventory_banshee_essence.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 500;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

