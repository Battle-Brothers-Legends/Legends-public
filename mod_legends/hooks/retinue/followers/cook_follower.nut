::mods_hookExactClass("retinue/followers/cook_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.cook";
		this.m.Name = "Cooking Equipment";
		this.m.Description = "A good warm meal goes a long way towards healing body and mind. A cook can only do so much with whatever there is to hand in the wilderness, Having the proper equipment to prepare meals makes sure that no provisions go to waste.";
		this.m.Image = "ui/campfire/legend_cook_01";
		this.m.Cost = 1000;
		this.m.Effects = [
			"Makes all provisions last 4 extra days"
		];

		this.addSkillRequirement("Have someone who's learned the Camp Cook perk. Guaranteed on Bakers, Fishwives, Cannibals and Butchers, may be rarely found on many others", [
			::Legends.Perks.getID(::Legends.Perk.LegendCampCook),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("FoodAdditionalDays" in this.World.Assets.m)
			this.World.Assets.m.FoodAdditionalDays = 4;
		//if ("HitpointsPerHourMult" in this.World.Assets.m)
			//this.World.Assets.m.HitpointsPerHourMult = 1.33;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

