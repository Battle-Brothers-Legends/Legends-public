this.legends_zombie_high_xbow <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieHeavyXbow;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_rotten_flesh"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;

		this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "worn_mail_shirt"],
			[1, "patched_mail_shirt"],
			[1, "ragged_surcoat"]
		]));


		local item = this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "kettle_hat"],
			[1, "padded_kettle_hat"],
			[1, "dented_nasal_helmet"],
			[1, "mail_coif"],
			[1, "full_leather_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
