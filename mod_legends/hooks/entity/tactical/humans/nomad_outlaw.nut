::mods_hookExactClass("entity/tactical/humans/nomad_outlaw", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			"weapons/scimitar",
			"weapons/scimitar",
			"weapons/oriental/nomad_mace",
			"weapons/boar_spear",
			"weapons/oriental/polemace",
			"weapons/oriental/light_southern_mace",
			"weapons/oriental/two_handed_saif",
			"weapons/two_handed_wooden_hammer",
			"weapons/woodcutters_axe",
			"weapons/battle_whip",
			"weapons/three_headed_flail"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 66)
		{
			local shields = [
				"shields/oriental/southern_light_shield",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Southern.plated_nomad_mail],
			[1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_00],
			[1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_01],
			[1, ::Legends.Armor.Standard.theamson_nomad_outlaw_armor],
			[3, ::Legends.Armor.Southern.leather_nomad_robe]
		]));

		local helmet = [
			[3, ::Legends.Helmet.Southern.nomad_leather_cap],
			[2, ::Legends.Helmet.Southern.nomad_light_helmet],
			[3, ::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_01],
			[1, ::Legends.Helmet.Standard.theamson_nomad_outlaw_helmet],
			[2, ::Legends.Helmet.Southern.nomad_reinforced_helmet],
			[1, ::Legends.Helmet.Southern.leather_head_wrap]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
