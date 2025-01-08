::mods_hookExactClass("entity/tactical/humans/barbarian_beastmaster", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.removeByID("effects.dodge");
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Overwhelm);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendOnslaught);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendAlert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBalance);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecFists);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
		}
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/barbarians/thorned_whip"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "barbarians/hide_and_bone_armor"]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "barbarians/beastmasters_headpiece"]
		]));
	}
});
