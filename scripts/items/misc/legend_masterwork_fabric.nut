this.legend_masterwork_fabric <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_masterwork_fabric";
		this.m.Name = "Masterwork Fabric";
		this.m.Description = "A bolt of double-quilted fabric with a mysterious, stamped mark. The material is light, thick and still flexible enough to be combined with other rare materials to make something stronger.";
		this.m.Icon = "misc/legend_masterwork_fabric.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 950;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

