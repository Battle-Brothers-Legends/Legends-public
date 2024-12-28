this.hedge_knight_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.hedge_knight";
		this.m.Name = "Hedge Knight";
		this.m.Icon = "ui/backgrounds/background_33.png";
		this.m.BackgroundDescription = "Hedge Knights are competitive individuals that excel in fighting man against man with brute strength and heavy armor, but less so in cooperating with others or in swiftness.";
		this.m.GoodEnding = "A man like %name% would always find a way. The hedge knight eventually, if not inevitably, left the company and set out on his own. Unlike many other brothers, he did not spend his crowns on land or ladders with which to climb the noble life. Instead, he bought himself the finest war horses and the talents of armorers. The behemoth of a man rode from one jousting tournament to the next, winning them all with ease. He\'s still at it to this day, and you think he won\'t stop until he\'s dead. The hedge knight simply knows no other life.";
		this.m.BadEnding = "%name% the hedge knight eventually left the company. He traveled the lands, returning to his favorite past time of jousting, which was really a cover for his real favorite past time of lancing men off horses in a shower of splinters and glory. At some point, he was ordered to \'throw\' a match against a pitiful and gangly prince to earn the nobleman some prestige. Instead, the hedge knight drove his lance through the man\'s skull. Furious, the lord of the land ordered the hedge knight killed. They say over a hundred soldiers took to his home and only half returned alive.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.legend_fear_nobles",
			"trait.ailing",
			"trait.swift",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic",
			"trait.legend_light",
			"trait.legend_frail",
			"trait.legend_seductive"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Lone Wolf",
			"the Wolf",
			"the Hound",
			"Steelwielder",
			"the Slayer",
			"the Jouster",
			"the Giant",
			"the Mountain",
			"Strongface",
			"the Defiler",
			"the Knightslayer",
			"the Hedge Knight"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Crusader;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
			Class = [],
			Magic = []
		}
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.BackgroundDescription = "Hedge Knights are competitive individuals that excel in fighting head to head with brute strength and heavy armor, but less so in cooperating with others or in swiftness.";
		this.m.GoodEnding = "A woman like %name% would always find a way. The hedge knight eventually, if not inevitably, left the company and set out on her own. Unlike many other comrades, she did not spend her crowns on land or ladders with which to climb the noble life. Instead, she bought herself the finest war horses and the talents of armorers. The behemoth of a woman rode from one jousting tournament to the next, winning them all with ease. She\'s still at it to this day, and you think she won\'t stop until she\'s dead. The hedge knight simply knows no other life.";
		this.m.BadEnding = "%name% the hedge knight eventually left the company. She traveled the lands, returning to her favorite past time of jousting, which was really a cover for her real favorite past time of lancing men off horses in a shower of splinters and glory. At some point, she was ordered to \'throw\' a match against a pitiful and gangly prince to earn the nobleman some prestige. Instead, the hedge knight drove her lance through the man\'s skull. Furious, the lord of the land ordered the hedge knight killed. They say over a hundred soldiers took to her home and only half returned alive.";

	}



	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Some women are born to be feared. Well over six feet tall, %name%\'s stature alone is a threatening one. | %name%\'s shadow casts over smaller people - and they seem to only further shrink when she walks by. | Standing amongst people like a bear in a suit of armor, %name% earns plenty of double-takes. | Years of brutal combat with her equally huge siblings left %name% a scarred and scary figure.} {The hedge knight has spent many seasons taking her prized horse to jousting tournaments. Unfortunately, a polearm crowned her mount, leaving her without a ride. | A mercenary in the company of herself, the hedge knight wandered for years, doing battle for those who offered the most crowns. | When she cleaved five men with one swing, three of which were on her side, the hedge knight was banned from service in every army in the land. | Ordered to kill a lord\'s enemies, the hedge knight kicked in the door of a family and slaughtered them all with her bare hands. When the lord refused to pay, %name% killed him, too. | The hedge knight has spent many nights sleeping peacefully beneath a pale moon - and just as many days killing ruthlessly beneath a shining sun.} {Always on the hunt for more crowns, the company of sellswords seemed like a good fit. | Too terrifying to be employed for long, %name% seeks the company of men who will not piss themselves when she grabs a weapon. | Tired of killing jousters and lords, as well as women and children, %name% sees mercenary work as something of a vacation. | War has apparently gotten in the way of %name%\'s jousting career. She seeks to amend that problem.}";
		}
		else
		{
			return "{Some men are born to be feared. Well over six feet tall, %name%\'s stature alone is a threatening one. | %name%\'s shadow casts over smaller men - and they seem to only further shrink when he walks by. | Standing amongst men like a bear in a suit of armor, %name% earns plenty of double-takes. | Years of brutal combat with his equally huge brothers left %name% a scarred and scary figure.} {The hedge knight has spent many seasons taking his prized horse to jousting tournaments. Unfortunately, a polearm crowned his mount, leaving him without a ride. | A mercenary in the company of himself, the hedge knight wandered for years, doing battle for those who offered the most crowns. | When he cleaved five men with one swing, three of which were on his side, the hedge knight was banned from service in every army in the land. | Ordered to kill a lord\'s enemies, the hedge knight kicked in the door of a family and slaughtered them all with his bare hands. When the lord refused to pay, %name% killed him, too. | The hedge knight has spent many nights sleeping peacefully beneath a pale moon - and just as many days killing ruthlessly beneath a shining sun.} {Always on the hunt for more crowns, the company of sellswords seemed like a good fit. | Too terrifying to be employed for long, %name% seeks the company of men who will not piss themselves when he grabs a weapon. | Tired of killing jousters and lords, as well as women and children, %name% sees mercenary work as something of a vacation. | War has apparently gotten in the way of %name%\'s jousting career. He seeks to amend that problem.}";
		}

	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				12,
				13
			],
			Bravery = [
				4,
				9
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				10,
				11
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				9,
				12
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-14,
				-7
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
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/greatsword"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "mail_hauberk"],
			[1, "basic_mail_shirt"],
			[1, "scale_armor"],
			[1, "reinforced_mail_hauberk"],
			[1, "worn_mail_shirt"]
		]));

		local helm = [
			[1, "nasal_helmet"],
			[1, "nasal_helmet_with_mail"],
			[1, "mail_coif"],
			[1, "bascinet_with_mail"],
			[1, "closed_flat_top_helmet"]
		];


		helm.push([1, "theamson_barbute_helmet"]);


		items.equip(this.Const.World.Common.pickHelmet(helm));
	}
});

