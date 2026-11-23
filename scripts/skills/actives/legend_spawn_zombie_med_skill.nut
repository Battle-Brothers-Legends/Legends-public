this.legend_spawn_zombie_med_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieMed);
		this.m.Description = "Summon a fallen yeoman and send it charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/fashion_body.png";
		this.m.IconDisabled = "skills/fashion_body_bw.png";
		this.m.Overlay = "fashion_body";
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
		this.m.Script = "scripts/entity/tactical/legends_zombie_med";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 7;
		this.m.HPCost = 20;
		this.m.APStartMult = 0.0;
	}

});
