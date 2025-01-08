::mods_hookExactClass("entity/tactical/humans/barbarian_drummer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendDrumsOfWar);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Overwhelm);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendAlert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBalance);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendOnslaught);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecFists);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
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
				[1, "barbarians/thick_furs_armor"],
				[1, "barbarians/animal_hide_armor"],
				[1, "barbarians/reinforced_animal_hide_armor"]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, "barbarians/leather_headband"],
			[1, "barbarians/bear_headpiece"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
