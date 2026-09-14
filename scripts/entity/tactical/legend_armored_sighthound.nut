this.legend_armored_sighthound <- this.inherit("scripts/entity/tactical/legend_sighthound", {

	m = { }

	function create() {
		this.legend_sighthound.create();
	}

	function assignRandomEquipment() {
		this.m.Items.equip(this.new("scripts/items/armor/special/wardog_armor"));
	}

})
