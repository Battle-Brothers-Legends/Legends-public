::mods_hookExactClass("entity/tactical/humans/barbarian_madman", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
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
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/named/named_rusty_warblade"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}



		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "barbarians/barbarian_ritual_armor"]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "barbarians/barbarian_ritual_helmet"]
			]));
		}
	}
});
