this.legend_spawn_skeleton_low_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnSkeletonLow);
		this.m.Description = "Unleash your skeleton and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/arrange_bones.png";
		this.m.IconDisabled = "skills/arrange_bones_bw.png";
		this.m.Overlay = "arrange_bones";
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
		this.m.Script = "scripts/entity/tactical/legends_skeleton_low";
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 15;
		this.m.HPCost = 10;

	}

});
