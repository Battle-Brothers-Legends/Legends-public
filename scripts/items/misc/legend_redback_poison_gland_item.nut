this.legend_redback_poison_gland_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_redback_poison_gland";
		this.m.Name = "Redback Poison Gland";
		this.m.Description = "The poison gland of a Redback. Should not be carried close to any food or drink.";
		this.m.Icon = "misc/inventory_redback_poison.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2500;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

