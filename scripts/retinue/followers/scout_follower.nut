this.scout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
		this.m.Name = "Watcher's Totem";
		this.m.Description = "The people of the woods and hinterlands swear that the presence of this totem grants good fortune to those around it, somehow preventing sickness and accidents as long as it is in the camp. Sounds like farking nonsense but if it keeps them happy...";
		this.m.Image = "ui/campfire/legend_scout_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"Reduces the movement penalty of difficult terrain by 15%",
			"Prevents sickness and accidents due to terrain"
		];

		this.addSkillRequirement("Have at least one of the following backgrounds: Wildman/Wildwoman, Hunter, Lumberjack, Ranger, Master Archer", [
			"background.wildman",
			// "background.wildwoman",
			"background.hunter",
			"background.lumberjack",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.legend_master_archer",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = ++i )
		{
			if (this.Const.World.TerrainTypeSpeedMult[i] <= 0.65 && this.Const.World.TerrainTypeSpeedMult[i] > 0.0)
			{
				this.World.Assets.m.TerrainTypeSpeedMult[i] *= (this.Const.World.TerrainTypeSpeedMult[i] + 0.15) / this.Const.World.TerrainTypeSpeedMult[i];
			}
		}
	}
});

