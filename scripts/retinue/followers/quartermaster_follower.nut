this.quartermaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.quartermaster";
		this.m.Name = "Ordered Inventory";
		this.m.Description = "With years of experience from traveling with caravans, the Quartermaster is able to squeeze and rotate any piece of gear, luggage or armor into the perfect spot to use space as efficiently as possible.";
		this.m.Image = "ui/campfire/legend_quartermaster_01";
		this.m.Cost = 1500;
		this.m.Effects = [
			"Increases the amount of ammunition you can carry by 100",
			"Increases the amount of medical supplies and tools you can carry by 50 each"
		];

		this.addSkillRequirement("Have someone with the Skillful Stacking perk. Guaranteed on Vagabonds, Millers, Donkeys and many others", [
			::Legends.Perks.getID(::Legends.Perk.LegendSkillfulStacking),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("AmmoMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.AmmoMaxAdditional = 100;
		if ("MedicineMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.MedicineMaxAdditional  = 50;
		if ("ArmorPartsMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.ArmorPartsMaxAdditional = 50;
	}
});

