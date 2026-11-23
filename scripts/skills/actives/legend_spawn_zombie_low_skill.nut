this.legend_spawn_zombie_low_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieLow);
		this.m.Description = "Summon a fallen peasant and send it charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/mold_carrion.png";
		this.m.IconDisabled = "skills/mold_carrion_bw.png";
		this.m.Overlay = "mold_carrion";
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
		this.m.Script = "scripts/entity/tactical/legends_zombie_low";
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
		this.m.HPCost = 15;
	}

});
