::mods_hookExactClass("entity/tactical/humans/nomad_archer", function(o)
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
				"weapons/oriental/composite_bow",
				"ammo/quiver_of_arrows"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		weapons = [
			"weapons/knife",
			"weapons/wooden_stick",
			"weapons/oriental/nomad_mace",
			"weapons/oriental/saif"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));


		local armor = [
			[2, "oriental/nomad_robe"],
			[2, "oriental/thick_nomad_robe"],
			[1, "oriental/cloth_sash"],
			// [1, "citrene_nomad_cutthroat_armor_00"],
			// [1, "citrene_nomad_cutthroat_armor_01"],
			[3, "nomad_archer_armor_00"]
		]

		local helmet = [
			[2, "oriental/nomad_head_wrap"],
			[3, "oriental/nomad_head_wrap"],
			[1, "citrene_nomad_ranged_helmet_00"],
			[3, "oriental/nomad_leather_cap"]
		]

		local outfits = [
			[1, "dark_southern_outfit_00"]
		]

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item)
		}
	}
});
