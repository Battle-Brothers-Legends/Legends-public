::mods_hookExactClass("skills/backgrounds/gambler_background", function(o)
{
	o.create = function()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Gambler);
		this.m.Name = "Gambler";
		this.m.Icon = "ui/backgrounds/background_20.png";
		this.m.BackgroundDescription = "Gamblers tend to have quick reflexes and a higher resolve than their opponents at the card table.";
		this.m.GoodEnding = "It was perhaps a risk to take a gambler like %name% into your ranks. Now, many days later it\'s obvious you made the right choice. Last you heard, %they% was still with the company and uses %their% earnings to enrich %their% habits. Rumor has it that, through all %their% winnings, %they%\'s secretly become one of the richest men in all the land. You think it\'s a bunch of hogwash, but a surprising number of mayors have become suddenly lax on gaming...";
		this.m.BadEnding = "%name% the gambler retired from the declining company and returned to %their% gambling ways. %They% quickly acquired great debts %they% could not pay. You saw %them% begging on a street corner with one of %their% hands missing and gaps in %their% teeth. You dropped a few crowns into %their% tin and said a few words, but %they% did not recognize you.";
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
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
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
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Performing;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleThick, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Thick, Hairs = ::Const.Hair.CommonMale, HairColors = ::Const.HairColors.Young});
	}

	o.onBuildDescription <- function ()
	{
		return "{They say luck is the devil, so just how long can a gambler like %name% play with it? | Everyone gambles, so %name% figured why not do it for money? | Dice, cards, marbles - there are a lot of ways to take a man\'s money, and %name% knows all of them. | %name%\'s got the eyes of a desert snake - and shaping cards is %their% rattle. | In a world of life or death, taking risks is %name%\'s game. | A %person% like %name% sees everything coming, especially the next card in the deck.} {%They% supported %themselves% by playing cards from town to town, only leaving after %they%\'d cleaned out their pockets. | But it is a mystery as to how a %person% decides to take up cards as a lifestyle. | The constant coming and going of mercenaries made for easy targets - until one sore loser ran %them% off with a bastard sword. | Orphaned by %their% own birth, %they%\'s always scrounged up a living by gambling with others. | When %they% was a kid, a trickster\'s cup-game showed %them% the value in hustling. | When %their% father fell into gambling debts, %they% figured the best way to pay them back was to become an even better hustler %themselves%. | After taking all their crowns, towns across the land banned %name% from hustling in a fit of so-called \'religious revival.\'} {Now, the gambler seeks to throw %their% dice into the wind - as well as the mud, taking rank with any outfit that pays. | One has to wonder what a cardplayer is doing not playing cards. Then again, maybe it\'s good that %they% sees your group as a smart gamble. | Perhaps years of scamming mercenaries has given %them% the notion that %they% could just as easily be one. | Clever and quick-thinking, the cardshaper survives by moving before anyone else does, a skill as useful as any other in this world. | Ironically, a bad play put %them% into enormous debt with a baron. Now %they% has to find another way to pay it back. | Wars have sapped most of the fish from %their% cards games. Instead of waiting around %they% figured %they%\'d just go ahead and follow them.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Gambler);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.noble_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[2, ::Legends.Armor.None]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[3, ::Legends.Helmet.None]
		]))

	}

});
