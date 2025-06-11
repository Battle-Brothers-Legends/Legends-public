this.dawg_armor_upgrade_item <- inherit("scripts/items/misc/wardog_armor_upgrade_item", {

	m = {}

	function create() {
		this.wardog_armor_upgrade_item.create();
		this.m.ID = "misc.wardog_armor_upgrade";
		m.Name = "Wardog Armor";
		m.Description = "A simple leather coat that can be donned by any wardog to give it some protection in combat.";
		m.Icon = "armor_upgrades/upgrade_21.png";
		m.Value = 200;
	}

	function playInventorySound(_eventType) {
		Sound.play("sounds/combat/armor_leather_impact_03.wav", Const.Sound.Volume.Inventory);
	}

	function onUse(_actor, _item = null) {
		local dog = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory) : _item;

		if (dog == null || dog.getID() != "accessory.legend_dawg") {
			return false;
		}

		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
		local new_dog = null;

		if (dog.getID() == "accessory.legend_dawg") {
			new_dog = this.new("scripts/items/accessory/legend_armored_dawg_item");
		}

		if (new_dog == null) {
			return false;
		}

		new_dog.setName(dog.getName());
		new_dog.setVariant(dog.getVariant());
		_actor.getItems().unequip(dog);
		_actor.getItems().equip(new_dog);
		return true;
	}
});
