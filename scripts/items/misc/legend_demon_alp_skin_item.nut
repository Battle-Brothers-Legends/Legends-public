this.legend_demon_alp_skin_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_demon_alp_skin";
		this.m.Name = "Demon Alp Skin";
		this.m.Description = "This skin taken from an Demon Alp is leathery and seems to ooze ichor.";
		this.m.Icon = "misc/inventory_demonalp_skin.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 3000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

