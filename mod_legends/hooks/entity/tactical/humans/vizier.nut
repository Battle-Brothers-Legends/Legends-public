::mods_hookExactClass("entity/tactical/humans/vizier", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		if (this.getGender()) {
			this.m.Name = ::String.replace(this.m.Name, "Ibn ", "Bint "); // changes southern "son of" to "daughter of"
		}
	}

	o.assignRandomEquipment = function () {
		if (::Math.rand(1, 100) <= 50) {
			local variants = ["03", "04"];
			this.getSprite("surcoat").setBrush("bust_desert_noble_" + variants[::Math.rand(0, variants.len() - 1)]);
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.padded_mail_and_lamellar_hauberk],
			[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
			[1, ::Legends.Armor.Southern.vizier_gear]
		]));

		if (::Math.rand(1, 100) <= 80) {
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[5, ::Legends.Helmet.Southern.vizier_headgear],
				[1, ::Legends.Helmet.Standard.legend_noble_southern_crown],
				[1, ::Legends.Helmet.Standard.legend_noble_southern_hat]
			]));
		}
	}
});
