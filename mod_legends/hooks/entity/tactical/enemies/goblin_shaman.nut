::mods_hookExactClass("entity/tactical/enemies/goblin_shaman", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([0.5, "scripts/items/misc/legend_ancient_scroll_item"]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendWindReader);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_staff"));
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_shaman_armor]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_shaman_helmet]
		]);
		this.m.Items.equip(item);
	}
});
