this.legend_spawn_zombie_low_xbow_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieLowXbow);
		this.m.Description = "Unleash your zombie and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/zombie_archer_01_square.png";
		this.m.IconDisabled = "skills/zombie_archer_01_square_bw.png";
		this.m.Overlay = "zombie_archer_01_square";
		 this.m.SoundOnUse = [
		 	"sounds/combat/meat_01.wav",
		 	"sounds/combat/meat_02.wav",
		 	"sounds/combat/meat_03.wav",
			"sounds/combat/meat_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem =  "spawns.zombie";
		this.m.Script = "scripts/entity/tactical/legends_zombie_low_xbow";
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 6;
		this.m.HPCost = 10;
	}

});
