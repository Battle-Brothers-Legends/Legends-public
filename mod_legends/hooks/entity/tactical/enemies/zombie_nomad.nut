::mods_hookExactClass("entity/tactical/enemies/zombie_nomad", function(o) 
{
	o.assignRandomEquipment = function()
	{
		local weapons = [
			"weapons/oriental/saif",
			"weapons/scimitar",
			"weapons/oriental/nomad_mace",
			"weapons/boar_spear",
			"weapons/bludgeon",
			"weapons/butchers_cleaver",
			"weapons/oriental/light_southern_mace",
			"weapons/oriental/two_handed_saif",
			"weapons/two_handed_wooden_hammer",
			"weapons/woodcutters_axe"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			local shields = [
				"shields/oriental/southern_light_shield"
			];
			local shield = this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]);

			if (this.Math.rand(1, 100) <= 66)
			{
				shield.setCondition(this.Math.round(shield.getConditionMax() / 2 - 1));
			}

			this.m.Items.equip(shield);
		}

		local aList = [
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Southern.plated_nomad_mail],
			[1, ::Legends.Armor.Southern.leather_nomad_robe],
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe]
		];
		local armor = this.Const.World.Common.pickArmor(aList);
		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
		}
		this.m.Items.equip(armor);

		local helmet = [
			[1, ::Legends.Helmet.Southern.nomad_leather_cap],
			[1, ::Legends.Helmet.Southern.nomad_light_helmet],
			[1, ::Legends.Helmet.Southern.nomad_reinforced_helmet],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap]
		];
		local helm = this.Const.World.Common.pickHelmet(helmet);

		if (this.Math.rand(1, 100) <= 66)
		{
			helm.setArmor(this.Math.round(helm.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(helm);
	}
});