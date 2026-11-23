this.legend_greater_flesh_golem_armed <- this.inherit("scripts/entity/tactical/enemies/greater_flesh_golem", {
	m = {},
	function onInit() {
		this.greater_flesh_golem.onInit();
	}

	function assignRandomEquipment() {
		this.m.Items.equip(this.new("scripts/items/helmets/golems/flesh_golem_facewrap"));
		this.m.Items.equip(this.new("scripts/items/armor/golems/flesh_golem_robes"));
		local weapons = [
			"weapons/scramasax",
			"weapons/military_pick",
			"weapons/morning_star",
			"weapons/hand_axe",
			"weapons/flail",
			"weapons/boar_spear",
			"weapons/arming_sword"
		];
		local weapon = weapons[this.Math.rand(0, weapons.len() - 1)];
		this.m.Items.equip(this.new("scripts/items/" + weapon));
		if (!this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.updateDualWield();
		}
	}

	function makeMiniboss () {
		if (!this.actor.makeMiniboss()) {
			return false;
		}
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		this.getSprite("miniboss").setBrush("bust_miniboss_undead");
		local weapons = [
			"weapons/named/named_cleaver",
			"weapons/named/named_sword",
			"weapons/named/named_mace",
			"weapons/named/named_flail",
			"weapons/named/named_axe",
			"weapons/named/named_spear",
			"weapons/named/named_warhammer"
		];
		local weapon = weapons[this.Math.rand(0, weapons.len() - 1)];
		this.m.Items.equip(this.new("scripts/items/" + weapon));
		if (!this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.updateDualWield();
		}

		return true;
	}

});

