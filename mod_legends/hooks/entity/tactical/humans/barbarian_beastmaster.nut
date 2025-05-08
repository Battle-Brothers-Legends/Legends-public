::mods_hookExactClass("entity/tactical/humans/barbarian_beastmaster", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Effects.remove(this, ::Legends.Effect.Dodge);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		}
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/barbarians/thorned_whip"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Barbarian.hide_and_bone_armor]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.beastmasters_headpiece]
		]));
	}
});
