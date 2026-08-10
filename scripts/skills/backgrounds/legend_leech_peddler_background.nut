this.legend_leech_peddler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendLeechPeddler);
		this.m.Name = "Leech Peddler";
		this.m.Icon = "ui/backgrounds/background_leech_peddler.png";
		this.m.BackgroundDescription = "Leech peddlers are of questionable mindset at the best of times, but their unusual remedies often help those who cannot afford a real healer.";
		this.m.GoodEnding = "%name% continued %their% bizarre adventure after you left %companyname%, soon after %they% made %their% way back to the swamps in search of new 'pets'. %They% happened to bump into a {wildwoman | wildman} who was almost as deranged as %they% is. %They% quickly formed a bond and it is said %they% adopted children and now leave peacefully in the swamp. However you suspect said children are really just more leeches.";
		this.m.BadEnding = "%name% went off to join another mercenary company in a large city somewhere. %They% traveled with what is said to be a witch hunter and a small boy. What became of %name% is unknown at that point - some say they were killed... or worse.";
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
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Lowborn;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.CrossbowTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.FitTree,
				::Const.Perks.OrganisedTree,
				::Const.Perks.AgileTree,
				::Const.Perks.CalmTree
			],
			Enemy = [
				::Const.Perks.BeastTree
			],
			Class = [
				::Const.Perks.HealerClassTree
			],
			Profession = [
				::Const.Perks.HealerProfessionTree,
				::Const.Perks.HerbalistProfessionTree
			],
			Magic = [
			]
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.Monk, Beards = ::Const.Beards.Monk});
	}

	function onBuildDescription() {
			return "{%name% is an odd sort - clearly unhinged enough to go hunting for bloodsucking worms but also to treat them as %their% own children. | If you look closely, %name% will stroke a small jar of leeches under %their% arm and 'play' with them - as if playing with an infant. | If you listen carefully, you can make out %name% pressing %their% lips to the glass jar of angry leeches and whispering to them about this and that. | No matter the weather, the leeches must be cared and accounted for. | %name% will frequently dive into pools of murky water for more leeches. The location or current situation they perform this in seems to have no impact on them. | If you look closely, you can make out that the leeches are scared of %name% and, under no circumstances, attempt to feed off %them%. Makes you wonder if they know something you don\'t... | Everyone needs a hobby, and %name% managed to make %their% dreams become reality - even if that means wading waist deep through cold, murky water. | In a time of war, healers are always needed. However the profession can be somewhat...muddy at times. Often requiring mercenaries to look for alternative methods for healing.} {%name% talks at length about how to catch and care for leeches, often three or four times a day. Everyone normally zones out during these times however, so what %name% says could well be gibberish. | %name% assures you %they% is of sound mind - often saying that %they% worked for nobles. However the fact that %they% is still wading through water looking for bloodsucking worms may say a lot about that venture. | %name% sometimes breaks into a weep - going into detail about how %they% once sold leeches and never forgave %themselves% for it. Someone normally has to hug %them% to stop the flow of tears and sobbing. | %Their% background is somewhat a mystery - %they% lives as a hermit would but is educated like a scribe would be. Perhaps %they% wasn\'t always like this? | %They% offers you a fat leech, one of the largest you have ever seen. You shake your head sideways. Dejected they kiss the leech on where it\'s forehead would be, before pushing it gently back in the jar. | %name% sometimes goes in depth about how %they% was once in love. However at the end of the story you still have doubts as if this mystery lover is a person or a leech. | The peddler assures you that all %their% leeches have names. %They% presses %their% finger against the razor maw of each leech pushing angrily against their glass prison but you interject in time to say that won\'t be needed. Somehow %they% still seems happy. | %name% says that this job puts food on the table for their family. You eye the jar of leeches and ask where they live. But you think you already know what %they% mean.} {It didn\'t take long for war and famine to find %name%\'s village, but instead of being forced out %they% made a tidy sum offering 'leech based services' to the dying locals. %They% also refuses to say what became of all of them. | %name% is always happy to find a bountiful harvest - however you suspect they do not mean crops or other things normal people would mean by that. | %name% was captured by bandits a few nights ago. Where any other %person% would\'ve been beaten, killed or worse, the bandits instead decided to let %them% go. Looking at the way %they% strokes that jar, you can see why. | %name% says %they% founded a cult just outside of %randomtown%, %they% asks you if you\'d like to guess as to what they worshipped. But you suspect you know the answer already. | When asked as to why %they% would join a band of militia, %name% simply stares over your shoulder, occasionally breaking character to check if %their% leeches are still okay. | %name% says they tried to be a merchant at one point in life, but it turns out everyone else is \'too uneducated\' to appreciate the value of leech companions.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLeechPeddler);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 1) {
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.thick_dark_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[2, ::Legends.Helmet.Standard.feathered_hat],
			[3, ::Legends.Helmet.Standard.headscarf]
		]));
	}
});
