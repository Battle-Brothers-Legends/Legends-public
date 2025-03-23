this.recruiter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
		this.m.Name = "Pre-filled Contracts";
		this.m.Description = "The deviousness of a pre-filled contract that needs a single signiture can make the labours of arguing about pay a thing of the past. Just simply sign on the line and you are ready to go! Just don't let them read the small print.";
		this.m.Image = "ui/campfire/legend_recruiter_01";
		this.m.Cost = 1500;
		this.m.Effects = [
			"Makes you pay 10% less up front for hiring new men, and 50% less for tryouts",
			"Makes between 2 and 4 additional men available to recruit in every settlement"
		];

		this.addSkillRequirement("Have a mercenary who has taken the Inspiring Presence perk. Guaranteed on Cultists, Pimps, Retired Soldiers and many others.", [
			::Legends.Perks.getID(::Legends.Perk.InspiringPresence),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("RosterSizeAdditionalMin" in this.World.Assets.m)
			this.World.Assets.m.RosterSizeAdditionalMin += 2;
		if ("RosterSizeAdditionalMax" in this.World.Assets.m)
			this.World.Assets.m.RosterSizeAdditionalMax  += 4;
		if ("HiringCostMult" in this.World.Assets.m)
			this.World.Assets.m.HiringCostMult *= 0.9;
		if ("TryoutPriceMult" in this.World.Assets.m)
			this.World.Assets.m.TryoutPriceMult *= 0.5;
	}
});

