::mods_hookExactClass("entity/tactical/enemies/skeleton_priest", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([5, "scripts/items/misc/legend_ancient_scroll_item"]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_priest_attire]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[99, ::Legends.Helmet.Ancient.ancient_priest_diadem]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});
