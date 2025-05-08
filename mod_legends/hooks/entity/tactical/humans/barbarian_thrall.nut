::mods_hookExactClass("entity/tactical/humans/barbarian_thrall", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/claw_club"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 40)
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
			}
		}

		if (this.Math.rand(1, 100) <= 20)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.thick_furs_armor],
			[1, ::Legends.Armor.Barbarian.animal_hide_armor],
			[2, ::Legends.Armor.None]
		]));


		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.bear_headpiece],
			[2, ""]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
