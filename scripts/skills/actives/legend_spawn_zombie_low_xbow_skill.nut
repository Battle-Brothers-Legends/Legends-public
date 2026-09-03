this.legend_spawn_zombie_low_xbow_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create() {
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieLowXbow);
		this.m.Description = "Unleash your zombie and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/meat", 4);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/enemies/necromancer", 3);
		this.m.SpawnItem =  "spawns.zombie";
		this.m.Script = "scripts/entity/tactical/legends_zombie_low_xbow";
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 6;
		this.m.HPCost = 10;
	}
});
