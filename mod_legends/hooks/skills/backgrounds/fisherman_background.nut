::mods_hookExactClass("skills/backgrounds/fisherman_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.fisherman";
		this.m.Name = "Fisherman";
		this.m.Icon = "ui/backgrounds/background_15.png";
		this.m.BackgroundDescription = "Fishermen are used to physical labor.";
		this.m.GoodEnding = "%name% retired from fighting and returned to his fishing ventures. A huge storm ran up the shores, destroying every skiff and drifter - except that wily fisherman\'s! The only boat afloat, %name%\'s business boomed. He lives a comfortable life waking up to a nice beachfront view every morning.";
		this.m.BadEnding = "With the fighting career going so poorly, %name% decided to retire from the field and return to fishing. He went missing at sea after an enormous storm wrecked the shorelines.";
		this.m.HiringCost = 78;
		this.m.DailyCost = 9;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fat)
		];
		this.m.Titles = [
			"the Fisherman",
			"the Fisher"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree
			],
			Enemy = [
				this.Const.Perks.LindwurmTree
			],
			Class = [
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.SpearfisherClassTree
			],
			Profession = [], 
			Magic = []
		}
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% loved the sea and the serenity of fishing alone on the water | Ironically, %name% always hated the water, but became a fisherman after his father and his father\'s father | %name% was a strong and able fisherman | %name% was content with being a fisherman | %name% always had a lucky hand in finding the best fishing grounds and catching the fattest fish}. As long as there was no storm, he was out there, fishing, day in and out. {Sadly, his fishing cabin burned to the ground while he was out at sea. | But disaster struck as he lost his best friend at sea when a storm suddenly came up, leaving him with a badly damaged boat and no one to sail out with. | But disaster struck when his wife died during childbirth, shattering all what he held dear. | After being unable pay his debts for some time, however, his boat was taken from him by a merciless loan shark. | It was after he strangled his wife in a fit of rage that he lost all interest in the fishing trade. | Much to his dismay, for almost a whole summer most of the fish he caught was already dead and rotten inside. | It was after a priest of the gods told %name% that the life of a fisherman was not what they desired of him, but that they wished for him to spill blood in their name, that he would set his eyes on another trade.} Visiting the tavern one evening, a new opportunity presented itself with the promise of coin for dangerous work.";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				3,
				5
			],
			Bravery = [
				-2,
				2
			],
			Stamina = [
				2,
				4
			],
			MeleeSkill = [
				3,
				6
			],
			RangedSkill = [
				4,
				9
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				5,
				10
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.straw_hat],
			[1, ::Legends.Helmet.None]
		]));
	}
});
