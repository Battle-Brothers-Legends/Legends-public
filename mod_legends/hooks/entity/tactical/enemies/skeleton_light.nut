::mods_hookExactClass("entity/tactical/enemies/skeleton_light", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/falx"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		}

		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_ripped_cloth]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);



		item = this.Const.World.Common.pickHelmet([
			[66, ::Legends.Helmet.Ancient.ancient_household_helmet],
			[34, ::Legends.Helmet.None]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
