this.legend_stollwurm_scales_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_stollwurm_scales";
		this.m.Name = "Stollwurm Scales";
		this.m.Description = "The shimmering green scales of a stollwurm are among the most reputable trophies a beast hunter can bring home from his adventures.";
		this.m.Icon = "misc/inventory_stollwurm_scales.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 6000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

