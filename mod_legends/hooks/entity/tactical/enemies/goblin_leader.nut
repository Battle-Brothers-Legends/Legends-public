::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendTrueBeliever);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.InspiringPresence);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
		local item = this.Const.World.Common.pickArmor([
			[1, "greenskins/goblin_leader_armor"]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[1, "greenskins/goblin_leader_helmet"]
		]);
		this.m.Items.equip(item);
	}
});
