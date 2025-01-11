this.bowyer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.bowyer";
		this.m.Name = "Bowyer";
		this.m.Icon = "ui/backgrounds/background_29.png";
		this.m.BackgroundDescription = "Bowyers tend to have some knowledge about how to use the ranged weaponry they used to craft.";
		this.m.GoodEnding = "While at a jousting tournament, a young boy was using an oddly shaped, yet perfectly crafted bow. His aiming hand was shaky, yet the arrows did not wobble upon being loosed. After he won the competition, you inquired about where the boy had gotten such an incredible bow. He stated that a bowyer by the name of %name% had crafted it. Apparently, he\'s known for making the finest bows in all the land!";
		this.m.BadEnding = "After you left the %companyname%, you sent a letter inquiring about the status of %name% the bowyer. You got word that he had discovered a way to craft the finest bow possible and, instead of giving this secret to the company, he departed to start his own business. He did not get far: whatever he had learned about his trade died with him on a muddy road out {north | south | west | east} of here, his body ironically skewered with what is said to have been a dozen arrows.";
		this.m.HiringCost = 80;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendFirm)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill
		];
		this.m.Titles = [
			"the Bowyer",
			"the Fletcher",
			"the Arrowmaker",
			"the Patient"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Ranger;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.CalmTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	}

	//Default Male -1 = male, 1 = female
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Fletcher";
		this.m.Icon = "ui/backgrounds/background_fletcher.png";
		this.m.BackgroundDescription = "Fletchers have a good understanding of how bows and crossbows work, even if they do lack practical experience.";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "While at a jousting tournament, a young girl was using an oddly shaped, yet perfectly crafted bow. Her aiming hand was shaky, yet the arrows did not wobble upon being loosed. After she won the competition, you inquired about where the girl had gotten such an incredible bow. She stated that a bowyer by the name of %name% had given it to her. Apparently, she\'s known for making the finest bows in all the land!";
		this.m.BadEnding = "After you left the %companyname%, you sent a letter inquiring about the status of %name% the fletcher. You got word that she had discovered a way to craft the finest arrow possible and, instead of giving this secret to the company, she departed to start his own business. She did not get far: whatever she had learned about her trade died with her on a muddy road out {north | south | west | east} of here, her body ironically skewered with what is said to have been a dozen arrows.";
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{With calloused hands and an eye for thin strings, | Born to a blacksmith, it\'s definitely somewhat curious that | Picking up her trade from a long lineage of strong-sighted forefathers,} %name% is a fletcher and bowyer. {Plying her trade for royalty, her career came to an end when a bowstring snapped, cutting off the finger of a promising heir. | Unfortunately, war destroyed the forests from which she used to draw the finest wood. | Sadly, she sold arrows to a young boy which led to a horrible, arrow-related accident. After much debate, she was no longer wanted in town. | But after so many years of making weapons for others, she began to wonder what else there was to life besides wood and string.} {Now, %name% seeks a different path. If she can\'t sell arrows, maybe she can use them. | Now %name% rests in the company of the very men she used to supply. | With her interest in bowmaking gone, can the former bowyer shoot arrows as well as she makes them?}";
		}
		else
		{
			return "{With calloused hands and an eye for thin strings, | Born to a blacksmith, it\'s definitely somewhat curious that | Picking up his trade from a long lineage of strong-sighted forefathers,} %name% is a fletcher and bowyer. {Plying his trade for royalty, his career came to an end when a bowstring snapped, cutting off the finger of a promising heir. | Unfortunately, war destroyed the forests from which he used to draw the finest wood. | Sadly, he sold a bow to a young boy which led to a horrible, arrow-related accident. After much debate, he was no longer wanted in town. | But after so many years of making weapons for others, he began to wonder what else there was to life besides wood and string.} {Now, %name% seeks a different path. If he can\'t sell bows, maybe he can use them. | Now %name% rests in the company of the very men he used to supply. | With his interest in bowmaking gone, can the former bowyer shoot arrows as well as he makes them?}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				4
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				-5,
				0
			],
			RangedSkill = [
				10,
				10
			],
			MeleeDefense = [
				-2,
				0
			],
			RangedDefense = [
				2,
				3
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "apron"]
		]));


		local item = this.Const.World.Common.pickHelmet([
				[1, "feathered_hat"],
				[2, ""]
		])
		items.equip(item);
	}
});

