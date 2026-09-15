this.legend_witch_leader_hair_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_witch_leader_hair";
		this.m.Name = "Witch Leader Hair";
		this.m.Description = "Long and brittle strands of glowing hair taken from a Hexe Leader. Their hair is said to have powerful properties in creating potions and elixirs. But then again, it\'s also said that Hexen keep the genitals of their victims as pets, so information attained from the peasantry might not be especially reliable.";
		this.m.Icon = "misc/inventory_hexe_leader_hair.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 5000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/cloth_01.wav", ::Const.Sound.Volume.Inventory);
	}

});

