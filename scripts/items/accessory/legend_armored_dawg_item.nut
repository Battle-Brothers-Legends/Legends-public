this.legend_armored_dawg_item <- this.inherit("scripts/items/accessory/legend_dawg_item", {
	m = {},

	function create() {
		this.legend_dawg_item.create();
		this.m.ID = "accessory.legend_armored_dawg";
		this.m.Description = "A strong and loyal southern hound bred for war. Can be unleashed in battle for scouting, tracking or running down routing enemies. This one wears a leather coat for protection against cutting wounds.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.ArmorScript = "scripts/items/armor/legend_dawg_armor";
		this.m.Value = 400;
	}

	function setEntity(_e) {
		this.m.Entity = _e;
		if (this.m.Entity != null) {
			this.m.Icon = "tools/dog_01_leash_70x70.png";
		} else {
			this.m.Icon = "tools/dawg_01_0" + this.m.Variant + "_armor_01_70x70.png";
		}
	}

});
