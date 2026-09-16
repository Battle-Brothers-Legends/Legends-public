this.legend_demon_hound_bones_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_demon_hound_bones";
		this.m.Name = "Demon Hound Bones";
		this.m.Description = "A few bones from a Höllenhund; they still have a faint, eerie glow about them.";
		this.m.Icon = "misc/inventory_demon_hound_bones.png";
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

