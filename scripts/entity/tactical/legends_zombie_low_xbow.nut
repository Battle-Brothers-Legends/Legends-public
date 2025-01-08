this.legends_zombie_low_xbow <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieLightXbow;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
		this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_rotten_flesh"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLastStand);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[2, "linen_tunic"],
			[1, "sackcloth"],
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"],
			[1, "apron"],
			[1, "butcher_apron"],
			[1, "monk_robe"]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[67, ""],
			[7, "hood"],
			[7, "aketon_cap"],
			[7, "full_aketon_cap"],
			[7, "open_leather_cap"],
			[7, "full_leather_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
