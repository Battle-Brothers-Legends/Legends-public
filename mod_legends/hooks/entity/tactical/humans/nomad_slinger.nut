::mods_hookExactClass("entity/tactical/humans/nomad_slinger", function(o)
{
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function () {
		local weapons = [
			"weapons/oriental/nomad_sling",
			"weapons/legend_sturdy_sling",
			"weapons/legend_sturdy_sling",
			"weapons/legend_sturdy_sling",
			"weapons/legend_sturdy_sling"

		];
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30) {
			weapons = ["weapons/oriental/nomad_sling"];
		}
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		weapons = [
			"weapons/knife",
			"weapons/wooden_stick"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		local armors = [
			[3, ::Legends.Armor.Southern.nomad_robe],
			[2, ::Legends.Armor.Southern.thick_nomad_robe],
			[3, ::Legends.Armor.Southern.cloth_sash]
		];
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40) {
			armors.extend([
				[1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_00],
				[1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_01],
			]);
		}
		this.m.Items.equip(this.Const.World.Common.pickArmor(armors));
		local helmet = [
			[3, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_00],
			[1, ::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_01],
			[2, ::Legends.Helmet.Southern.nomad_leather_cap]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
