this.legend_masterwork_fabric <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_masterwork_fabric";
		this.m.Name = "Masterwork Fabric";
		this.m.Description = "A bolt of double-quilted fabric with a mysterious, stamped mark. The material is light, thick and still flexible enough to be combined with other rare materials to make something stronger.";
		this.m.Icon = "misc/legend_masterwork_fabric.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1140;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

