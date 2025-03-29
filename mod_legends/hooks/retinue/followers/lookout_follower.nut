::mods_hookExactClass("retinue/followers/lookout_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.lookout";
		this.m.Name = "Outrider's Post";
		this.m.Description = "Having a quick Lookout with sharp eyes travel in advance of the company can prove invaluable in being aware of dangers and points of interests before others become aware of the company.";
		this.m.Image = "ui/campfire/legend_lookout_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"Increases your sight radius by 25%",
			"Reveals extended information about footprints"
		];

		this.addSkillRequirement("Have someone with the Lookout perk. Guaranteed on Thief, Poacher, Nomad and many others", [
			::Legends.Perks.getID(::Legends.Perk.LegendLookout),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("VisionRadiusMult" in this.World.Assets.m)
			this.World.Assets.m.VisionRadiusMult = 1.25;
		if ("IsShowingExtendedFootprints" in this.World.Assets.m)
			this.World.Assets.m.IsShowingExtendedFootprints = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

