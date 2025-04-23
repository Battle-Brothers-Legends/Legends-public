::mods_hookExactClass("entity/tactical/humans/nomad_cutthroat", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			"weapons/oriental/saif",
			"weapons/oriental/saif",
			"weapons/oriental/nomad_mace",
			"weapons/oriental/nomad_mace",
			"weapons/wooden_stick",
			"weapons/militia_spear",
			"weapons/militia_spear",
			"weapons/bludgeon",
			"weapons/butchers_cleaver"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local shields = [
				"shields/oriental/southern_light_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Southern.nomad_robe],
			[2, ::Legends.Armor.Southern.thick_nomad_robe],
			[2, ::Legends.Armor.Southern.cloth_sash],
			// [1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_00],
			// [1, ::Legends.Armor.Standard.citrene_nomad_cutthroat_armor_01],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));

		local helmet = [
			[2, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_00],
			[1, ::Legends.Helmet.Standard.citrene_nomad_cutthroat_helmet_01],
			[2, ::Legends.Helmet.Southern.nomad_head_wrap],
			[2, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_leather_cap]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
