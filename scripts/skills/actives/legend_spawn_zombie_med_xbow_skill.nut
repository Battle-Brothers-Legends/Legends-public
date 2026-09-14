this.legend_spawn_zombie_med_xbow_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create() {
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieMedXbow);
		this.m.Description = "Unleash your zombie and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/meat", 4);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/enemies/necromancer", 3);
		this.m.SpawnItem =  "spawns.zombie";
		this.m.Script = "scripts/entity/tactical/legends_zombie_med_xbow";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 8;
		this.m.HPCost = 20;
		this.m.APStartMult = 0.5;
	}
});
