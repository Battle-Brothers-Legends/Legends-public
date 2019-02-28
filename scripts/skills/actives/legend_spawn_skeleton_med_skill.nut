this.legend_spawn_skeleton_med_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		this.m.ID = "actives.legend_spawn_skeleton_med_skill";
		this.m.Name = "Summon Medium Skeleton";
		this.m.Description = "Unleash your skeleton and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/align_joints.png",
		this.m.IconDisabled = "skills/align_joints_bw.png",
		this.m.Overlay = "active_26";
		// this.m.SoundOnUse = [
		// 	"sounds/enemies/geist_idle_10.wav",
		// 	"sounds/enemies/geist_idle_11.wav",
		// 	"sounds/enemies/geist_idle_12.wav"
		// ];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem =  "spawns.skeleton",
		this.m.Script = "scripts/entity/tactical/legends_skeleton_med"
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 16;
		this.m.HPCost = 10;
		this.m.APStartMult = 0.5;


	}

});
