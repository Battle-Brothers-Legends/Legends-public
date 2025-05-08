::mods_hookExactClass("entity/tactical/humans/militia_guest", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMilitia);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SpecSpear);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearWall);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendThrustMaster);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}


		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
		}
		if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[1, ::Legends.Armor.Standard.apron]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.hood],
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.open_leather_cap],
				[1, ::Legends.Helmet.Standard.full_leather_cap],
				[1, ::Legends.Helmet.Standard.headscarf]
			]))
		}
	}
});
