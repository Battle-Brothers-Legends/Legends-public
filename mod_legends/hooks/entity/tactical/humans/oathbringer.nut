::mods_hookExactClass("entity/tactical/humans/oathbringer", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.OnDeathLootTable.extend([
			[1.0, "scripts/items/misc/legend_masterwork_fabric"],
			[2.5, "scripts/items/misc/legend_masterwork_metal"],
			[1.5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	o.assignRandomEquipment = function () {
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand)) {
			local weapons = [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand)) {
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/two_handed_hammer"
				]);
			}

			if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand)) {
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand)) {
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 60) {
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
		} else {
			::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body)) {
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.adorned_heavy_mail_hauberk]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head)) {
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, ::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail],
				[2, ::Legends.Helmet.Standard.adorned_full_helm],
				[1, ::Legends.Helmet.Standard.full_helm]
			]));
		}
	}

	o.makeMiniboss = function () {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/named_two_handed_hammer"
		];

		if (this.Const.DLC.Unhold) {
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen) {
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}

		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_wing_shield",
			"shields/named/named_rider_on_horse_shield",
			"shields/named/named_golden_round_shield",
			"shields/named/named_full_metal_heater_shield"
		]);
		local armor = [
			[1, ::Legends.Armor.Named.golden_scale_armor],
			[1, ::Legends.Armor.Named.heraldic_mail_armor]
		];

		if (this.Const.DLC.Wildmen) {
			armor.extend([
				[1, ::Legends.Armor.Named.named_golden_lamellar_armor],
				[1, ::Legends.Armor.Named.named_sellswords_armor]
			]);
		}
		local r = this.Math.rand(1, 3);

		if (r == 1) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		} else if (r == 2) {
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		} else if (r == 3) {
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		return true;
	}
});
