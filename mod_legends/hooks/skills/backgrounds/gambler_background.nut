::mods_hookExactClass("skills/backgrounds/gambler_background", function(o)
{
	o.create = function()
	{
		this.character_background.create();
		this.m.ID = "background.gambler";
		this.m.Name = "Gambler";
		this.m.Icon = "ui/backgrounds/background_20.png";
		this.m.BackgroundDescription = "Gamblers tend to have quick reflexes and a higher resolve than their opponents at the card table.";
		this.m.GoodEnding = "It was perhaps a risk to take a gambler like %name% into your ranks. Now, many days later it\'s obvious you made the right choice. Last you heard, he was still with the company and uses his earnings to enrich his habits. Rumor has it that, through all his winnings, he\'s secretly become one of the richest men in all the land. You think it\'s a bunch of hogwash, but a surprising number of mayors have become suddenly lax on gaming...";
		this.m.BadEnding = "%name% the gambler retired from the declining company and returned to his gambling ways. He quickly acquired great debts he could not pay. You saw him begging on a street corner with one of his hands missing and gaps in his teeth. You dropped a few crowns into his tin and said a few words, but he did not recognize you.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic)
		];
		this.m.Titles = [
			"Deuces",
			"the Wild Card",
			"the Luck Maker",
			"the Lucky",
			"the Cardsharper",
			"the Gambler"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.StaffTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.DeviousTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = []
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		
		if (_gender != 1) return;

		this.m.Name = "Gambler";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleThick;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "It was perhaps a risk to take a gambler like %name% into your ranks. Now, many days later it\'s obvious you made the right choice. Last you heard, she was still with the company and uses her earnings to enrich her habits. Rumor has it that, through all her winnings, she\'s secretly become one of the richest women in all the land. You think it\'s a bunch of hogwash, but a surprising number of mayors have become suddenly lax on gaming...";
		this.m.BadEnding = "%name% the gambler retired from the declining company and returned to her gambling ways. She quickly acquired great debts she could not pay. You saw her begging on a street corner with one of her hands missing and gaps in her teeth. You dropped a few crowns into her tin and said a few words, but she did not recognize you.";
	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{They say luck is the devil, so just how long can a gambler like %name% play with it? | Everyone gambles, so %name% figured why not do it for money? | Dice, cards, marbles - there are a lot of ways to take a man\'s money, and %name% knows all of them. | %name%\'s got the eyes of a desert snake - and shaping cards is her rattle. | In a world of life or death, taking risks is %name%\'s game. | A woman like %name% sees everything coming, especially the next card in the deck.} {She supported herself by playing cards from town to town, only leaving after she\'d cleaned out their pockets. | But it is a mystery as to how a woman decides to take up cards as a lifestyle. | The constant coming and going of mercenaries made for easy targets - until one sore loser ran her off with a bastard sword. | Orphaned by her own birth, she\'s always scrounged up a living by gambling with others. | When she was a kid, a trickster\'s cup-game showed her the value in hustling. | When her father fell into gambling debts, she figured the best way to pay them back was to become an even better hustler herself. | After taking all their crowns, towns across the land banned %name% from hustling in a fit of so-called \'religious revival.\'} {Now, the gambler seeks to throw her dice into the wind - as well as the mud, taking rank with any outfit that pays. | One has to wonder what a cardplayer is doing not playing cards. Then again, maybe it\'s good that she sees your group as a smart gamble. | Perhaps years of scamming mercenaries has given her the notion that she could just as easily be one. | Clever and quick-thinking, the cardshaper survives by moving before anyone else does, a skill as useful as any other in this world. | Ironically, a bad play put her into enormous debt with a baron. Now she has to find another way to pay it back. | Wars have sapped most of the fish from her cards games. Instead of waiting around she figured she\'d just go ahead and follow them.}";
		}
		else
		{
			return "{They say luck is the devil, so just how long can a gambler like %name% play with it? | Everyone gambles, so %name% figured why not do it for money? | Dice, cards, marbles - there are a lot of ways to take a man\'s money, and %name% knows all of them. | %name%\'s got the eyes of a desert snake - and shaping cards is his rattle. | In a world of life or death, taking risks is %name%\'s game. | A man like %name% sees everything coming, especially the next card in the deck.} {He supported himself by playing cards from town to town, only leaving after he\'d cleaned out their pockets. | But it is a mystery as to how a man decides to take up cards as a lifestyle. | The constant coming and going of mercenaries made for easy targets - until one sore loser ran him off with a bastard sword. | Orphaned by his own birth, he\'s always scrounged up a living by gambling with others. | When he was a kid, a trickster\'s cup-game showed him the value in hustling. | When his father fell into gambling debts, he figured the best way to pay them back was to become an even better hustler himself. | After taking all their crowns, towns across the land banned %name% from hustling in a fit of so-called \'religious revival.\'} {Now, the gambler seeks to throw his dice into the wind - as well as the mud, taking rank with any outfit that pays. | One has to wonder what a cardplayer is doing not playing cards. Then again, maybe it\'s good that he sees your group as a smart gamble. | Perhaps years of scamming mercenaries has given him the notion that he could just as easily be one. | Clever and quick-thinking, the cardshaper survives by moving before anyone else does, a skill as useful as any other in this world. | Ironically, a bad play put him into enormous debt with a baron. Now he has to find another way to pay it back. | Wars have sapped most of the fish from his cards games. Instead of waiting around he figured he\'d just go ahead and follow them.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-2,
				-2
			],
			Bravery = [
				12,
				12
			],
			Stamina = [
				-6,
				-5
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
				2,
				2
			],
			Initiative = [
				10,
				12
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "noble_tunic"],
			[1, "linen_tunic"],
			[2, ""]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
				[1, "feathered_hat"],
				[3, ""]
		]))

	}

});
