this.minstrel_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.minstrel";
		this.m.Name = "Minstrel's Tent";
		this.m.Description = "A good song and story play a large part in creating the reputation of a company. A place to practice and reflect on these crafts will help to spread the word about your deeds to all ears - willing to hear them or not.";
		this.m.Image = "ui/campfire/legend_minstrel_01";
		this.m.Cost = 1000;
		this.m.Effects = [
			"Makes you earn 15% more renown with every action",
			"Makes tavern rumors more likely to contain useful information"
		];

		this.addSkillRequirement("Have someone with the Entice perk. Guaranteed on Minstrels and Troubadours", [
			::Legends.Perks.getID(::Const.Perks.PerkDefs.LegendEntice),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("BusinessReputationRate" in this.World.Assets.m)
			this.World.Assets.m.BusinessReputationRate *= 1.15;
		if ("IsNonFlavorRumorsOnly" in this.World.Assets.m)
			this.World.Assets.m.IsNonFlavorRumorsOnly = true;
	}

});

