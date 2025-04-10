::mods_hookExactClass("skills/backgrounds/messenger_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.messenger";
		this.m.Name = "Messenger";
		this.m.Icon = "ui/backgrounds/background_46.png";
		this.m.BackgroundDescription = "Messengers are used to long and tiring travels.";
		this.m.GoodEnding = "The oddity of having %name% the messenger in your band did not seem so strange after %they% showed %themselves% to be a killer sellsword. As far as you know, %they%\'s still with the company, preferring the march of a mercenary to that of a messenger. You don\'t blame %them%: an errand %child% must bend the knee to every nobleman %they% comes across, but in the company of sellswords %they%\'ll no doubt get the occasional chance to kill one of them bastards. Not a hard trade off to accept!";
		this.m.BadEnding = "%name% the messenger departed the %companyname% and returned to being an errand %child% for the letters of lieges. You tried to find out where the %person% had gone to and eventually tracked %them% down - or what was left of %them%. Unfortunately, \'don\'t shoot the messenger\' is not an adage well followed in these fractured lands.";
		this.m.HiringCost = 80;
		this.m.DailyCost = 9;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable)
		];
		this.m.Titles = [
			"the Messenger",
			"the Courier",
			"the Runner"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.1,//plains
			0.03, //swamp
			0.05, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.03, //mountains
			0.0, // ?
			0.1, //farmland
			0.03, // snow
			0.03, // badlands
			0.07, //highlands
			0.1, //stepps
			0.0, //ocean
			0.03, //desert
			0.1 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.SpearTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
		this.m.Bodies = this.Const.Bodies.Skinny;
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()
	{
		return "{Some people are so important that they require others to carry their words. %name% is such a %person% - the latter, that is. | %name%\'s shoulders are yoked with bags of mail, the receivers almost certainly dead on arrival. | To escape a life of servitude, %name% took up the vocation of a messenger. | With so many hurrying to find out the status of relatives, %name% has found ample work as a messenger. | %name% once traveled the land as a modest messenger. | The %child% of a long line of messengers, %name% took messages across the land for royalty and laymen alike. | Picking up a dead messenger\'s bags, %name% soon found %themselves% in the role of a would-be messenger. | Once a refugee, %name% figured %they% might as well deliver letters if %they% was already wandering the land.} {But making the rounds gets boring. The mail%person% seeks a new field of work. | Carrying love letters, the would-be adventurer wondered what the hell %they% was doing. | Claiming to be a budding hero, %name% now believes the task of delivering mail is beneath %them%. | Rain or sunshine, sure, snow or sleet, sure, but all out war? Maybe another time. | But after opening a letter that would ruin a goodhearted noble, the messenger decided to leave %their% post. | When robbers made %their% life hell, %name% figured %they%\'d be better off traveling in the company of armed men. | After sleeping with a mayor\'s daughter, the messenger had a small army on %their% heels. %They% figured %they%\'d best slip into a different outfit for %their% own safety.} {%name% has spent years memorizing messages. Now %they%\'ll have to remember keeping the shield wall as arrows rain down on it. | Ironically, %name% has never written anything in %their% life. | Rolling up %their% sleeves, %name% boasts %they% has one last message to give the world. Everybody look out. | Perhaps %their% joining mercenaries suggests that, indeed, the pen is not mightier than a sword. | %name% has a tendency to repeat everything said to %them%. Old messenger habits die hard. | Ironically, the well-traveled messenger has probably seen more horrors on the road than most of the men in the outfit. | Few, if any, of %name%\'s skills make %them% ready for combat. But %they% does have some sturdy legs, hopefully just not for running away.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				3,
				3
			],
			Initiative = [
				15,
				21
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "linen_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "hood"],
			[1, "straw_hat"]
		]));

	}
});
