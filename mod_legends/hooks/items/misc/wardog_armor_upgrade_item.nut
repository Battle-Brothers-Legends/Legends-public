::mods_hookExactClass("items/misc/wardog_armor_upgrade_item", function(o) {
	o.m.UpgradeableCreatures <- [
		["accessory.legend_wardog", "scripts/items/accessory/legend_armored_wardog_item"],
		["accessory.legend_warhound", "scripts/items/accessory/legend_armored_warhound_item"],
		["accessory.legend_sighthound", "scripts/items/accessory/legend_armored_sighthound_item"]
	];

	o.onUse = function(_actor, _item = null) {
		local dog = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory) : _item;

		if (dog == null) {
			return false;
		}

		local scripts = this.m.UpgradeableCreatures.filter(@(idx, entry) entry[0] == dog.getID()).map(@(it) it[1]);
		if (scripts.len() == 0) {
			return false;
		}

		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);

		local newDog = this.new(scripts[0]);

		if (newDog == null) {
			return false;
		}

		newDog.setName(dog.getName());
		newDog.setVariant(dog.getVariant());
		_actor.getItems().unequip(dog);
		_actor.getItems().equip(newDog);
		return true;
	}
});
