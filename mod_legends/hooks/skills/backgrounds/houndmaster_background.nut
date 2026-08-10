::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.Houndmaster);
		this.m.Name = "Houndmaster";
		this.m.Icon = "ui/backgrounds/background_50.png";
		this.m.BackgroundDescription = "Houndmasters are used to handle dogs of war.";
		this.m.GoodEnding = "Dogs were not simply \'hounds\' to %name%, despite %their% title as \'houndmaster.\' To %them%, they were the most loyal friends of %their% life. After leaving the company, %they% discovered an ingenious way to breed the animals specifically tailored to the desires of the nobility. Wanted a brutish beast for a guard dog? %They% could do it. Wanted something small and cuddly for the children? %They% could do that, too. The former mercenary now earns an incredible earning doing what %they% loves - working with dogs.";
		this.m.BadEnding = "What\'s merely a hound to one man is a loyal beast to %name%. After leaving the company, the houndmaster went out to work for the nobility. Unfortunately, %they% refused to let hundreds of %their% dogs be used as a battle vanguard to be thrown away for some short-lived tactical advantage. %They% was hanged for %their% \'traitorous ideals\'.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Tiny)
		];
		this.m.Titles = [
			"the Houndmaster",
			"the Kennelmaster",
			"the Dogkeeper"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Druid;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.ThrowingTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.SlingTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.HoundmasterClassTree
			],
			Profession = [
				::Const.Perks.DogBreederProfessionTree
			],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1)	{
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny});
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Wardogs unleashed by this character will start at confident morale"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
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

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Houndmaster);
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
	}

	o.onAddEquipment = function ()
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
			[1, ::Legends.Armor.Standard.ragged_surcoat]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.open_leather_cap],
			[1, ::Legends.Helmet.None]
		]));
	}

});
