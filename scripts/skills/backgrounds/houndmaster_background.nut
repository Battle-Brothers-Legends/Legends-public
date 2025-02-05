this.houndmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.houndmaster";
		this.m.Name = "Houndmaster";
		this.m.Icon = "ui/backgrounds/background_50.png";
		this.m.BackgroundDescription = "Houndmasters are used to handle dogs of war.";
		this.m.GoodEnding = "Dogs were not simply \'hounds\' to %name%, despite his title as \'houndmaster.\' To him, they were the most loyal friends of his life. After leaving the company, he discovered an ingenious way to breed the animals specifically tailored to the desires of the nobility. Wanted a brutish beast for a guard dog? He could do it. Wanted something small and cuddly for the children? He could do that, too. The former mercenary now earns an incredible earning doing what he loves - working with dogs.";
		this.m.BadEnding = "What\'s merely a hound to one man is a loyal beast to %name%. After leaving the company, the houndmaster went out to work for the nobility. Unfortunately, he refused to let hundreds of his dogs be used as a battle vanguard to be thrown away for some short-lived tactical advantage. He was hanged for his \'traitorous ideals\'.";
		this.m.HiringCost = 85;
		this.m.DailyCost = 11;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.bleeder",
			"trait.bright",
			"trait.asthmatic",
			"trait.fainthearted",
			"trait.tiny"
		];
		this.m.Titles = [
			"the Houndmaster",
			"the Kennelmaster",
			"the Dogkeeper"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Druid;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HoundmasterClassTree
			],
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
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Dogs were not simply \'hounds\' to %name%, despite her title as \'houndmaster.\' To her, they were the most loyal friends of her life. After leaving the company, she discovered an ingenious way to breed the animals specifically tailored to the desires of the nobility. Wanted a brutish beast for a guard dog? She could do it. Wanted something small and cuddly for the children? She could do that, too. The former mercenary now earns an incredible earning doing what she loves - working with dogs.";
		this.m.BadEnding = "What\'s merely a hound to some folks is a loyal beast to %name%. After leaving the company, the houndmaster went out to work for the nobility. Unfortunately, she refused to let hundreds of her dogs be used as a battle vanguard to be thrown away for some short-lived tactical advantage. She was hanged for her \'traitorous ideals\'.";

	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Wardogs unleashed by this character will start at confident morale."
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name%\'s fondness for dogs started after her father won a pup in a shooting contest. | When a dog saved her from a bear, %name% dedicated her life to the canine lot. | Seeing a dog stave off a would-be robber, %name%\'s fondness for the mutts only grew. | A young, bird-hunting %name% quickly saw the honor, loyalty, and workmanship of a dog. | Once bitten by a wild dog, %name% confronted her fear of canines by learning to train them.} {The houndmaster spent many years working for a local lord. She gave up the post after the liege struck a dog down just for sport. | Quick with training her mongrels, the houndmaster put her dogs into a lucrative traveling tradeshow. | The woman made a great deal of money on the dog-fighting circuits, her mutts renowned for their easily commanded - and unleashed - ferocity. | Employed by lawmen, the houndmaster used her strong-nosed dogs to hunt down many a criminal element. | Used by a local lord, many of the houndmaster\'s dogs found their way onto the battlefield. | For many years, the houndmaster used her dogs to help lift the spirits of orphaned children and the crippled.} {Now, though, %name% seeks a change of vocation. | When she heard word of a mercenary\'s pay, %name% decided to try her hand at being a sellsword. | Approached by a sellsword to buy one of her dogs, %name% became more interested in the prospect of she, herself, becoming a mercenary. | Tired of training dogs for this purpose or that, %name% seeks to train herself for... well, this purpose or that. | An interesting prospect, you can only hope %name% is as loyal as the dogs she once commanded.}";
		}
		else
		{
			return "{%name%\'s fondness for dogs started after his father won a pup in a shooting contest. | When a dog saved him from a bear, %name% dedicated his life to the canine lot. | Seeing a dog stave off a would-be robber, %name%\'s fondness for the mutts only grew. | A young, bird-hunting %name% quickly saw the honor, loyalty, and workmanship of a dog. | Once bitten by a wild dog, %name% confronted his fear of canines by learning to train them.} {The houndmaster spent many years working for a local lord. He gave up the post after the liege struck a dog down just for sport. | Quick with training his mongrels, the houndmaster put his dogs into a lucrative traveling tradeshow. | The man made a great deal of money on the dog-fighting circuits, his mutts renowned for their easily commanded - and unleashed - ferocity. | Employed by lawmen, the houndmaster used his strong-nosed dogs to hunt down many a criminal element. | Used by a local lord, many of the houndmaster\'s dogs found their way onto the battlefield. | For many years, the houndmaster used his dogs to help lift the spirits of orphaned children and the crippled.} {Now, though, %name% seeks a change of vocation. | When he heard word of a mercenary\'s pay, %name% decided to try his hand at being a sellsword. | Approached by a sellsword to buy one of his dogs, %name% became more interested in the prospect of he, himself, becoming a mercenary. | Tired of training dogs for this purpose or that, %name% seeks to train himself for... well, this purpose or that. | An interesting prospect, you can only hope %name% is as loyal as the dogs he once commanded.}";
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
				5,
				5
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				3,
				6
			],
			MeleeDefense = [
				3,
				3
			],
			RangedDefense = [
				1,
				2
			],
			Initiative = [
				12,
				18
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}
		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/accessory/legend_wardog_item"))
		}
		else
		{
			items.equip(this.new("scripts/items/accessory/legend_warhound_item"))
		}
		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "open_leather_cap"],
			[1, ""]
		]));
	}

});

