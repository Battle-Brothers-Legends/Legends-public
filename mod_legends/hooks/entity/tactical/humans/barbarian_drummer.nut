::mods_hookExactClass("entity/tactical/humans/barbarian_drummer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMinnesanger);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/claw_club"));
		}

		this.m.Items.equip(this.new("scripts/items/weapons/barbarians/drum_item"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Barbarian.thick_furs_armor],
				[1, ::Legends.Armor.Barbarian.animal_hide_armor],
				[1, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.bear_headpiece]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
