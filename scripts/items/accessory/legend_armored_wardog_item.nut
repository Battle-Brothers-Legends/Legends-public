this.legend_armored_wardog_item <- this.inherit("scripts/items/accessory/legend_wardog_item", {
	m = {},
	function create()
	{
		this.legend_wardog_item.create();
		this.m.ID = "accessory.legend_armored_wardog";
		this.m.Description = "A strong and loyal dog bred for war. Can be unleashed in battle for scouting, tracking or running down routing enemies. This one wears a leather coat for protection against cutting wounds.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.ArmorScript = "scripts/items/armor/special/wardog_armor";
		this.m.Value = 400;
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/dog_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/dog_01_0" + this.m.Variant + "_armor_01_70x70.png";
		}
	}

});

