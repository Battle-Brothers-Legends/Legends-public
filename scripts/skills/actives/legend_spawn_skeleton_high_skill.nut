this.legend_spawn_skeleton_high_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnSkeletonHigh);
		this.m.Description = "Unleash your skeleton and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/rebuild_skeleton.png";
		this.m.IconDisabled = "skills/rebuild_skeleton_bw.png";
		this.m.Overlay = "rebuild_skeleton";
		 this.m.SoundOnUse = [
		 	"sounds/combat/bones_01.wav",
		 	"sounds/combat/bones_02.wav",
		 	"sounds/combat/bones_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem =  "spawns.skeleton";
		this.m.Script = "scripts/entity/tactical/legends_skeleton_high";
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 19;
		this.m.HPCost = 30;
		this.m.APStartMult = 0.0;

	}

});
