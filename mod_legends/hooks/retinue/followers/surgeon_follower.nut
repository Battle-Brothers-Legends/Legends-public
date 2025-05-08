::mods_hookExactClass("retinue/followers/surgeon_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "Triage Table";
		this.m.Description = "Having an area set up and ready to treat the worst injuries could be the hair between life and death for the company. Maybe even yourself...one day.";
		this.m.Image = "ui/campfire/legend_surgeon_01";
		this.m.Cost = 1750;
		this.m.Effects = [
			"Makes every man without a permanent injury guaranteed to survive an otherwise fatal blow",
			"Makes every injury take one less day to heal"
		];

		this.addSkillRequirement("Have someone with the Field Triage perk. Guaranteed on Monks and Nuns", [
			::Legends.Perks.getID(::Legends.Perk.LegendFieldTriage),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("IsSurvivalGuaranteed" in this.World.Assets.m)
			this.World.Assets.m.IsSurvivalGuaranteed = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

