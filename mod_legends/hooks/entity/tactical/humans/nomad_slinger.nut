::mods_hookExactClass("entity/tactical/humans/nomad_slinger", function(o)
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
			[
				"weapons/oriental/nomad_sling"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		weapons = [
			"weapons/knife",
			"weapons/wooden_stick"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[3, "oriental/nomad_robe"],
			// [1, "citrene_nomad_cutthroat_armor_00"],
			// [1, "citrene_nomad_cutthroat_armor_01"],
			[2, "oriental/thick_nomad_robe"],
			[3, "oriental/cloth_sash"]
		]));
		local helmet = [
			[3, "oriental/nomad_head_wrap"],
			[1, "citrene_nomad_cutthroat_helmet_00"],
			[1, "citrene_nomad_cutthroat_helmet_01"],
			[2, "oriental/nomad_leather_cap"]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
