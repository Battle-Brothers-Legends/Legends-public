::mods_hookExactClass("entity/tactical/humans/councilman", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = (this.getGender() != 1 ? ::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)] : ::Const.Strings.CharacterNamesFemale[::Math.rand(0, ::Const.Strings.CharacterNamesFemale.len() - 1)]); // this is the town councilman
	}

	o.assignRandomEquipment = function () {
		local r = ::Math.rand(1, 11);
		local withDetail = true;
		local withHelmet = true;

		if (r <= 7) {
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.linen_tunic]
			]));

			if (::Math.rand(1, 100) <= 33) {
				this.m.Items.equip(::Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.feathered_hat]
				]));
				withHelmet = false;
			}
		} else if (r <= 9) {
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_tunic]
			]));
		} else if (r == 10) {
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.monk_robe]
			]));
			withDetail = false;
			withHelmet = false;
		} else if (r == 11) {
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.wizard_robe]
			]));
			withDetail = false;

			if (::Math.rand(1, 100) <= 50) {
				this.m.Items.equip(::Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.wizard_hat]
				]));
				withHelmet = false;
			}
		}

		if (withDetail && ::Math.rand(1, 100) <= 66) {
			local variants = ["01", "06", "07", "08", "09"];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[::Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && ::Math.rand(1, 100) <= 25) {
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.feathered_hat],
				[1, ::Legends.Helmet.Standard.noble_headgear]
			]));
		}
	}
});
