this.legends_zombie_med_xbow <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieMediumXbow;
		this.legend_zombie.onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_rotten_flesh"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));
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
