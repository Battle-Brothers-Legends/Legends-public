this.legend_illusionist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_illusionist";
		this.m.Icon = "ui/backgrounds/background_wizard.png";
		this.m.Name = "Illusionist";
		this.m.HiringCost = 1000;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.brave",
			"trait.athletic",
			"trait.bloodthirsty",
			"trait.brute",
			"trait.dexterous",
			"trait.eagleyes",
			"trait.fearless",
			"trait.huge",
			"trait.loyal",
			"trait.quick",
			"trait.swift",
			"trait.sure_footing",
			"trait.tough",
			"trait.disloyal",
			"trait.loyal"
		];
		this.m.Titles = [
			"the Enthralling",
			"the Fascinating",
			"the Speaker",
			"the Dreamer",
			"the Clairvoyant",
			"the Diviner"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing | this.Const.BackgroundType.Educated | this.Const.BackgroundType.Untalented;
		this.m.Level = 1;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];


		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SpearTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [
				this.Const.Perks.AlpTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.IllusionistMagicTree,
				this.Const.Perks.PremonitionMagicTree
			]
		}

	}

	//Default feMale
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 0) return;

		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.removeBackgroundType(this.Const.BackgroundType.Female);
	}



	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{ %name% is an expert in deception. |  %name% has an aluring gaze, as if knowing more than is aparent. | %name%\'s eyes have glint in any light  | Not much is known about %name%, not for sure. Everything is an indiscernable mix of truths and untruths | Where ever the greatest story is told, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s true feelings are rarely known, everything is an act, designed to create an appearance of truth | %name%\'s way with words is beguiling, you find yourself being drawn into conversation even when you have better things to be doing.} {%name% has lived many lives, depending who you ask | their past i but a mystery to most. | Some say %name% peered deep into the cup of stars and emerged with the ability to shape reality, others just say its all darned lies. | Who can say what is true in the past of one so good at spinning tales? | That history of %name% is subjective, each person you ask tells a different tale with complete honesty in their eyes. None of them agree, | One rumor says she traveled the land as a spellweaver. | Rumors of magic surround the woman, though some incredulous cynics are hardly impressed. | One rumor is that she was a conman, and another is that she\'s a sorcerer. You\'re not sure which you prefer. | With rumors of old magics stirring, the woman\'s magical proclamation just might be true. | Some say she sees the skenes of fate, and weaves new futures.} {You ask %name% a lot of questions, you hear an enthralling set of answers that keep you busy for hours. Despite all that detail you realize you have forgotten her answers. Or did you ask the questions at all? | %name% produces a dove from her sleeve. An old trick that fancies no one - until it turns in the air, returning to her as a crow. | %name% has shown the ability to shoot smoke from her mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a coin into the air. An amazing display that leaves the woman too tired to attempt it again. | Predictions of the weather are common, but %name% can make weather appear. | %name% asks to read your palms. You decline. Her presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. She seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of giant hungry eternal beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where she came from. You don\'t ask for a clarification on the matter.}";
		}
		else
		{
			return "{ %name% is an expert in deception. |  %name% has an aluring gaze, as if knowing more than is aparent. | %name%\'s eyes have glint in any light  | Not much is known about %name%, not for sure. Everything is an indiscernable mix of truths and untruths | Where ever the greatest story is told, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s true feelings are rarely known, everything is an act, designed to create an appearance of truth | %name%\'s way with words is beguiling, you find yourself being drawn into conversation even when you have better things to be doing.} {%name% has lived many lives, depending who you ask | their past i but a mystery to most. | Some say %name% peered deep into the cup of stars and emerged with the ability to shape reality, others just say its all darned lies. | Who can say what is true in the past of one so good at spinning tales? | That history of %name% is subjective, each person you ask tells a different tale with complete honesty in their eyes. None of them agree, | One rumor says he traveled the land as a spellweaver. | Rumors of magic surround the man, though some incredulous cynics are hardly impressed. | One rumor is that he was a conman, and another is that he\'s a sorcerer. You\'re not sure which you prefer. | With rumors of old magics stirring, the man\'s magical proclamation just might be true. | Some say he sees the skenes of fate, and weaves new futures.} {You ask %name% a lot of questions, you hear an enthralling set of answers that keep you busy for hours. Despite all that detail you realize you have forgotten her answers. Or did you ask the questions at all? | %name% produces a dove from his sleeve. An old trick that fancies no one - until it turns in the air, returning to him as a crow. | %name% has shown the ability to shoot smoke from his mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a coin into the air. An amazing display that leaves the man too tired to attempt it again. | Predictions of the weather are common, but %name% can make weather appear. | %name% asks to read your palms. You decline. His presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. He seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where he came from. You don\'t ask for a clarification on the matter.}";
		}
	}


	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-15,
				-20
			],
			Bravery = [
				15,
				10
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				-10,
				-10
			],
			RangedSkill = [
				20,
				15
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
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedDefense] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_seer_robes"]
		]));
		items.equip(this.new("scripts/items/weapons/legend_mystic_staff"));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "legend_seer_hat"]
		]));
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		// stash.add(this.new("scripts/items/supplies/black_marsh_stew_item"));
	}
});
