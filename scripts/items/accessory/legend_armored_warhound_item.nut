this.legend_armored_warhound_item <- this.inherit("scripts/items/accessory/legend_warhound_item", {
	m = {},
	function create()
	{
		this.legend_warhound_item.create();
		this.m.ID = "accessory.legend_armored_warhound";
		this.m.Description = "A strong and loyal northern hound bred for war. Can be unleashed in battle for scouting, tracking or running down routing enemies. This one wears a leather coat for protection against cutting wounds.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.ArmorScript = "scripts/items/armor/special/wardog_armor";
		this.m.Value = 450;
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/hound_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/hound_0" + this.m.Variant + "_armor_01_70x70.png";
		}
	}

});

