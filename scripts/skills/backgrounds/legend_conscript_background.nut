this.legend_conscript_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_conscript";
		this.m.Name = "Conscript";
		this.m.Icon = "ui/backgrounds/background_conscript.png";
		this.m.BackgroundDescription = "Better trained and equipped than northern militia, conscripts are the rank and file of the southern military.";
		this.m.GoodEnding = "The nomad %name% left the %companyname% a few months after yourself. He apparently traveled south and now leads what they\'re calling the \'City on Legs,\' a huge band of peoples that roam the deserts. It is apparently so rich and successful a society that the Viziers worry their own people will flock to it.";
		this.m.BadEnding = "You learned that %name% the nomad departed the company with the hope of finding new plains to roam. Apparently, he got the idea in his head that he would travel far to the north and land cozily with the barbarians there. To his credit, the barbarians and nomads share a similar lifestyle, culture, language, religion, laws, struggles, conflicts, and general appearances aside. The nomad was butchered almost instantly upon entrance to a barbarian encampment and his remains eaten in a warrior ritual.";
		this.m.HiringCost = 300;
		this.m.DailyCost = 35;
		this.m.DailyCostMult = 1.0;
		this.m.Excluded = [
			"trait.legend_hate_nobles",
			"trait.huge",
			"trait.weasel",
			"trait.fear_greenskins",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.dumb",
			"trait.clubfooted",
			"trait.drunkard",
			"trait.disloyal",
			"trait.tiny",
			"trait.fragile",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.insecure"
		];
		this.m.Titles = [
			"the Conscript"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMuscular;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.1, //stepps
				0.0, //ocean
				0.1, //desert
				0.2 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	}

	function onBuildDescription() //Male only // —
	{
		return "{Like many southerners, %name% is someone who grew up in the desert, however they were destined to not stray far from the city walls. | Born into a military family, %name% took up the tradiation of service to the Vizier from an early age. | %name% family has had a foothold in this area for some time — begging, trading and eventually carving out a life for their children on the backs of their own toil. | Nomads often wander, while conscripts like %name% wanted the adventure without the walking. | %name% rarely speaks of their time under the banner, but you get the impression that they find much of the work required of them below their expectations.} {Politics are differant here in the south, and you find %name% always treats you with respect and reverence — even if you suspect it is not sincere. | %name% had a recent falling out with their commanding officer — something about a mortar, a goat and a half dozen buckets of rice. | %name% narrowly avoided execution when they were found with several bottles of wine in their tent. The life of a conscript has not appealed to them since. | %name% always carries a set of \'lucky\' dice around — which have not been working correctly so far, based on how many questions they asked you about their pay. | After a greenskin ambush, %name% managed to survive by hiding in the barrel of a mortar, gently cooking themselves in the desert heat until they were found and warned for their cowardice.} {Mounting debts has caused them to seek a new path — either to escape their debtors or to earn enough coin to buy their way out of trouble. | While better trained and drilled than other militia, %name% does have some rough edges that could be rounded off — assuming you can get them away from the bottle. | A life of steel, gunpowder and searing heat is enough for anyone to want a change, and %name% intends to do just that. | %name% thought about running with some nomads for a while, but given the strength of the Vizier\'s army in which they saw first hand has made them reconsider and seek more legitimate employment. | While not as experienced as a professional soldier, %name% can stand alone and tall against almost any threat.}";
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
				8,
				8
			],
			Bravery = [
				10,
				5
			],
			Stamina = [
				4,
				0
			],
			MeleeSkill = [
				7,
				10
			],
			RangedSkill = [
				0,
				5
			],
			MeleeDefense = [
				5,
				10
			],
			RangedDefense = [
				5,
				2
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_throw_sand"));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/oriental/polemace"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
			items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, "oriental/linothorax"],
			[1, "oriental/southern_mail_shirt"]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/southern_head_wrap"],
			[1, "oriental/wrapped_southern_helmet"],
			[1, "oriental/spiked_skull_cap_with_mail"]
		]);
		items.equip(helm);
	}

});

