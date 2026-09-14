::mods_hookExactClass("entity/tactical/enemies/zombie_yeoman_bodyguard", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/shields/worn_heater_shield"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
			}
		}

		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.worn_mail_shirt],
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
		]);

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(armor.getArmorMax() / 2 - 1);
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.kettle_hat],
				[1, ::Legends.Helmet.Standard.padded_kettle_hat],
				[1, ::Legends.Helmet.Standard.dented_nasal_helmet],
				[1, ::Legends.Helmet.Standard.mail_coif],
				[1, ::Legends.Helmet.Standard.full_leather_cap]
			]);
			if (item != null)
			{
				if (this.Math.rand(1, 100) <= 66)
				{
					item.setArmor(item.getArmorMax() / 2 - 1);
				}
				this.m.Items.equip(item);
			}
		}
	}
});
