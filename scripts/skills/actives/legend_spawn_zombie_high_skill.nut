this.legend_spawn_zombie_high_skill <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {},
	function create()
	{
		this.legend_spawn_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSpawnZombieHigh);
		this.m.Description = "Summon a fallen knight and send them charging into the enemy. Needs a free tile adjacent.";
		this.m.Icon = "skills/remake_man.png";
		this.m.IconDisabled = "skills/remake_man_bw.png";
		this.m.Overlay = "remake_man";
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
		this.m.Script = "scripts/entity/tactical/legends_zombie_high";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 9;
		this.m.HPCost = 30;
		this.m.APStartMult = 0.0;

	}


});
