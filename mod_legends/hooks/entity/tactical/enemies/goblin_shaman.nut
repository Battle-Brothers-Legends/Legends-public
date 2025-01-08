::mods_hookExactClass("entity/tactical/enemies/goblin_shaman", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendTrueBeliever);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Nimble);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_staff"));
		local item = this.Const.World.Common.pickArmor([
			[1, "greenskins/goblin_shaman_armor"]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[1, "greenskins/goblin_shaman_helmet"]
		]);
		this.m.Items.equip(item);
	}
});
