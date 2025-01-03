::mods_hookExactClass("items/misc/wardog_heavy_armor_upgrade_item", function(o) {
	o.onUse = function ( _actor, _item = null )
	{
		local dog = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory) : _item;

		if (dog == null ||
			dog.getID() != "accessory.legend_wardog" &&
			dog.getID() != "accessory.legend_warhound" &&
			dog.getID() != "accessory.legend_armored_wardog" &&
			dog.getID() != "accessory.legend_armored_warhound"
		) {
			return false;
		}

		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
		local new_dog;

		if (dog.getID() == "accessory.legend_wardog" || dog.getID() == "accessory.legend_armored_wardog" )
			new_dog = this.new("scripts/items/accessory/legend_heavily_armored_wardog_item");
		else if (dog.getID() == "accessory.legend_warhound" || dog.getID() == "accessory.legend_armored_warhound")
			new_dog = this.new("scripts/items/accessory/legend_heavily_armored_warhound_item");

		if (new_dog == null)
			return false;

		new_dog.setName(dog.getName());
		new_dog.setVariant(dog.getVariant());
		_actor.getItems().unequip(dog);
		_actor.getItems().equip(new_dog);
		return true;
	}
});
