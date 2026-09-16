this.legend_stollwurm_blood_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_stollwurm_blood";
		this.m.Name = "Stollwurm Blood";
		this.m.Description = "The corroding blood of a Stollwurm that eats away at metal in no time. Luckily it can be safely transported in glass vials.";
		this.m.Icon = "misc/inventory_stollwurm_blood.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 4000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

