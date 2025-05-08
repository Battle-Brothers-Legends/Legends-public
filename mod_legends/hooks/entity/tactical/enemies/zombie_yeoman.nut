::mods_hookExactClass("entity/tactical/enemies/zombie_yeoman", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		}
		this.m.Skills.update();
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 7);

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
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
		}

		local aList = [
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.worn_mail_shirt],
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt]
		];
		local armor = this.Const.World.Common.pickArmor(aList);

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
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
					item.setArmor(this.Math.round(item.getArmorMax() / 2 - 1));
				}
				this.m.Items.equip(item);
			}
		}
	}
});
