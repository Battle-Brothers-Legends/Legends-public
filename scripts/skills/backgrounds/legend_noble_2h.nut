this.legend_noble_2h <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_noble_2h";
		this.m.Name = "Warrior";
		this.m.Icon = "ui/backgrounds/background_noble2h.png";
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
		this.m.DailyCostMult = 1.0;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.legend_hate_nobles",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.legend_fear_nobles",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.clubfooted",
			"trait.drunkard",
			"trait.disloyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.dexterous",
			"trait.legend_double_tongued"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.BackgroundDescription = "Noble House Warriors are drawn from peasant backgrounds, then trained in two handed weapons and heavy armor";
		this.m.GoodEnding = "Supporting your cause from the start, %name% was with you in retirement, leaving the company not long after you did. Though he was a lowly peasant, he proved himself in battle after battle and slowly became as trusted and valued a friend as one can have in a mercenary company.";
		this.m.BadEnding = "A supporter from the start, %name% was as loyal as he was talented. He stayed with the company for a time before eventually leaving to forge out a path for himself. The other day, you received a letter from the mercenary stating that he had started his own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of his company, you learned that it had been completely annihilated in a battle between nobles.";
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.TwoHandedTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [],
			Class = [],
			Magic = []
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

		this.m.GoodEnding = "Supporting your cause from the start, %name% was with you in retirement, leaving the company not long after you did. Though she was a lowly peasant, she proved herself in battle after battle and slowly became as trusted and valued a friend as one can have in a mercenary company.";
		this.m.BadEnding = "A supporter of your cause from the start, %name% was as loyal as she was talented. She stayed with the company for a time before eventually leaving to forge out a path for himself. The other day, you received a letter from the mercenary stating that she had started her own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of her company, you learned that it had been completely annihilated in a battle between nobles.";

	}



	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "Brooding and at times suicidal, it\'s no surprise that %name% is frequently found diving into battle with nothing more than a large two-hander. {Clothed in murderous intent, you once saw her cleave a man in two - top to bottom. | It is said that she once cleaved a warrior orc in two, leaving the trunk of its legs still standing. | The woman is known to ignore the fragility of her own mortality just to end the life of another. | She thrives being in the thick of battle where she can swing her weapons with little regard for safety or accuracy. | Supposedly, she once won a jousting tournament, but had to flee after bedding a watching nobleman\'s wife. | The woman is not a murderer, but she would have made a fine one. | Seemingly unstoppable at times, you are glad to have the woman on your side. | In a fit of bloodthirsty rage she once impaled two goblins on one pike. | A strong brute, you once saw %name% kill someone just on her backswing.} She\'ll use any weapon you give her, but %name% has a proclivity towards those that can make calamitous ruin out of a man\'s body.";
		}
		else
		{
			return "Brooding and at times suicidal, it\'s no surprise that %name% is frequently found diving into battle with nothing more than a large two-hander. {Clothed in murderous intent, you once saw him cleave a man in two - top to bottom. | It is said that he once cleaved a warrior orc in two, leaving the trunk of its legs still standing. | The man is known to ignore the fragility of his own mortality just to end the life of another. | He thrives being in the thick of battle where he can swing his weapons with little regard for safety or accuracy. | Supposedly, he once won a jousting tournament, but had to flee after bedding a watching nobleman\'s wife. | The man is not a murderer, but he would have made a fine one. | Seemingly unstoppable at times, you are glad to have the man on your side. | In a fit of bloodthirsty rage he once impaled two goblins on one pike. | A strong brute, you once saw %name% kill someone just on his backswing.} He\'ll use any weapon you give him, but %name% has a proclivity towards those that can make calamitous ruin out of a man\'s body.";
		}

	}

	function onPrepareVariables( _vars )
	{
		_vars.extend(this.World.Assets.getFounderNames());
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				12,
				17
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				3,
				6
			],
			RangedDefense = [
				2,
				4
			],
			Initiative = [
				-5,
				-10
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[2, "basic_mail_shirt"],
			[1, "gambeson"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "legend_enclave_vanilla_armet_01"],
			[10, "legend_enclave_vanilla_skullcap_01"],
			[50, "greatsword_hat"]
		]));

	}
});
