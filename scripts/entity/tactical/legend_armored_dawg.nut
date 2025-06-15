this.legend_armored_dawg <- this.inherit("scripts/entity/tactical/legend_dawg", {

	m = { }

	function create() {
		this.legend_dawg.create();
	}

	function assignRandomEquipment() {
		this.m.Items.equip(this.new("scripts/items/armor/special/wardog_armor"));
	}

})
