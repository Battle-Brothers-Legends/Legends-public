this.legend_leech_peddler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_leech_peddler";
		this.m.Name = "Leech Peddler";
		this.m.Icon = "ui/backgrounds/background_leech_peddler.png";
		this.m.BackgroundDescription = "Leech peddlers are of questionable mindset at the best of times, but their unusual remedies often help those who cannot afford a real healer.";
		this.m.GoodEnding = "%name% continued their bizaare adventure after you left %companyname%, soon after they made their way back to the swamps in search of new 'pets'. They happened to bump into a {wildwoman | wildman} who was almost derranged as they were. They quickly formed a bond and it is said they adopted children and now leave peacefully in the swamp. However you suspect said children are really just more leeches.";
		this.m.BadEnding = "%name% went off to join another mercanry company in a large city somewhere. They travelled with what is said to be a witch hunter and a small boy. What became of %name% is unknown at that point - some say they were killed... or worse.";
		this.m.HiringCost = 45;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Titles = [
			"the Unhinged",
			"the Slimy",
			"the Unsound",
			"the Jarman",
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.Monk;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Monk;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[2];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.04, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, //snow
				0.0, //badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [
				this.Const.Perks.LindwurmTree //lol, lmao.
			],
			Class = [
				this.Const.Perks.SickleClassTree,
				this.Const.Perks.HealerClassTree
			],
			Magic = [
			]
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% is an odd sort - clearly unhinged enough to go hunting for bloodsucking worms but also to treat them as their own children. | If you look closely, %name% will stroke a small jar of leeches under their arm and 'play' with them - as if playing with an infant. | If you listen carefully, you can make out %name% pressing their lips to the glass jar of angry leeches and whispering to them about this and that. | No matter the weather, the leeches must be cared and accounted for. | %name% will frequently dive into pools of murky water for more leeches. The location or current situation they perform this in seems to have no impact on them. | If you look closely, you can make out that the leeches are scared of %name% and, under no circamstances, attempt to feed off them. Makes you wonder if they know something you don\'t... | Everyone needs a hobby, and %name% managed to make their dreams become reality - even if that means wading waist deep through cold, murky water. | In a time of war, healers are always needed. However the profession can be somewhat...muddy at times. Often requiring mercenaries to look for alternative methods for healing.} {%name% talks at length about how to catch and care for leeches, often three or four times a day. Everyone normally zones out during these times however, so what %name% says could well be gibberish. | %name% assures you they are of sound mind - often saying that they worked for nobles. However the fact that they are still wading through water looking for bloodsucking worms may say a lot about that venture. | %name% sometimes breaks into a weep - going into detail about how they once sold leeches and never forgave themselves for it. Someone normally has to hug them to stop the flow of tears and sobbing. | Their background is somewhat a mystery - they live as a hermit would but are educated like a scribe would be. Perhaps they were never always like this? | They offer you a fat leech, one of the largest you have ever seen. You shake your head sideways. Dejected they kiss the leech on where it\'s forehad would be before comitting it back to the jar. | %name% sometimes goes into depth about how they were once in love with a young man. However at the end of the story you still have doubts as if to this mystery lover is a man or leech. | The peddler assures you that all their leeches have names. They go to press their finger against the razor maw of each leech pushing angrily against their glass prison but you interject in time to say that won\'t be needed. Somehow they still seem happy. | %name% says that this job puts food on the table for their family. You eye the jar of leeches and ask where they live. But you think you already know what she means.} {It didn\'t take long for war and famine to find %name%\'s village, but instead of being forced out they made a tidy sum offering 'leech based services' to the dying locals. They also refuse to say what became of all of them. | %name% is always happy to find a bountiful harvest - however you suspect they do not mean crops or other things normal people would mean by that. | %name% was captured by bandits a few nights ago. Where any other woman would\'ve been beaten and killed, the bandits instead decided to let her go. Looking at the way she strokes that jar, you can see why. | %name% says she founded a cult just outside of %randomtown%, she askes you if you\'d like to guess as to what they worshipped. But you suspect you know the answer already. | When asked as to why she would join a band of militia, %name% simply stares over your shoulder, occasioanlly breaking character to check her leeches are still okay. | %name% says they tried to be a merchant at one point in life, but it turns out everyone else is \'too uneducated\' to apprecaite the value of leech companions.}";
		}
		else
		{
			return "{%name% is an odd sort - clearly unhinged enough to go hunting for bloodsucking worms but also to treat them as their own children. | If you look closely, %name% will stroke a small jar of leeches under their arm and 'play' with them - as if playing with an infant. | If you listen carefully, you can make out %name% pressing their lips to the glass jar of angry leeches and whispering to them about this and that. | No matter the weather, the leeches must be cared and accounted for. | %name% will frequently dive into pools of murky water for more leeches. The location or current situation they perform this in seems to have no impact on them. | If you look closely, you can make out that the leeches are scared of %name% and, under no circamstances, attempt to feed off them. Makes you wonder if they know something you don\'t... | Everyone needs a hobby, and %name% managed to make their dreams become reality - even if that means wading waist deep through cold, murky water. | In a time of war, healers are always needed. However the profession can be somewhat...muddy at times. Often requiring mercenaries to look for alternative methods for healing.} {%name% talks at length about how to catch and care for leeches, often three or four times a day. Everyone normally zones out during these times however, so what %name% says could well be gibberish. | %name% assures you they are of sound mind - often saying that they worked for nobles. However the fact that they are still wading through water looking for bloodsucking worms may say a lot about that venture. | %name% sometimes breaks into a weep - going into detail about how they once sold leeches and never forgave themselves for it. Someone normally has to hug them to stop the flow of tears and sobbing. | Their background is somewhat a mystery - they live as a hermit would but are educated like a scribe would be. Perhaps they were never always like this? | They offer you a fat leech, one of the largest you have ever seen. You shake your head sideways. Dejected they kiss the leech on where it\'s forehad would be before comitting it back to the jar. | %name% sometimes goes into depth about how they were once in love with a young woman. However at the end of the story you still have doubts as if to this mystery lover is a man or leech. | The peddler assures you that all their leeches have names. They go to press their finger against the razor maw of each leech pushing angrily against their glass prison but you interject in time to say that won\'t be needed. Somehow they still seem happy. | %name% says that this job puts food on the table for their family. You eye the jar of leeches and ask where they live. But you think you already know what he means.} {It didn\'t take long for war and famine to find %name%\'s village, but instead of being forced out they made a tidy sum offering 'leech based services' to the dying locals. They also refuse to say what became of all of them. | %name% is always happy to find a bountiful harvest - however you suspect they do not mean crops or other things normal people would mean by that. | %name% was captured by bandits a few nights ago. Where any other man would\'ve been beaten and killed, the bandits instead decided to let him go. Looking at the way he strokes that jar, you can see why. | %name% says he founded a cult just outside of %randomtown%, he askes you if you\'d like to guess as to what they worshipped. But you suspect you know the answer already. | When asked as to why he would join a band of militia, %name% simply stares over your shoulder, occasioanlly breaking character to check his leeches are still okay. | %name% says they tried to be a merchant at one point in life, but it turns out everyone else is \'too uneducated\' to apprecaite the value of leech companions.}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				5
			],
			Bravery = [
				-3,
				-1
			],
			Stamina = [
				0,
				6
			],
			MeleeSkill = [
				0,
				5
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				5
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
		items.equip(this.new(""));
		}
		else if (r == 1)
		{
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"],
			[1, "linen_tunic", this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "aketon_cap"],
			[2, "feathered_hat"],
			[3, "headscarf"]
		]));
	}
});
