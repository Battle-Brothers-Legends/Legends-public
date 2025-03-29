this.legends_zombie_med_xbow <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieMediumXbow;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
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
		this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "worn_mail_shirt"],
			[1, "patched_mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "basic_mail_shirt"]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[25, ""],
			[11, "kettle_hat"],
			[11, "aketon_cap"],
			[11, "full_aketon_cap"],
			[11, "padded_kettle_hat"],
			[11, "dented_nasal_helmet"],
			[11, "mail_coif"],
			[11, "full_leather_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});
