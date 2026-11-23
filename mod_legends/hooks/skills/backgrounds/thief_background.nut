::mods_hookExactClass("skills/backgrounds/thief_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.thief";
		this.m.Name = "Thief";
		this.m.Icon = "ui/backgrounds/background_11.png";
		this.m.BackgroundDescription = "A good thief will have quick reflexes and the ability to evade any captors.";
		this.m.GoodEnding = "%name% the thief retired from fighting and disappeared off the map. You haven\'t heard word of the %person% since, but there are rumors that a certain nobleman had one of his vaults completely drained in a perfectly executed heist.";
		this.m.BadEnding = "%name% the thief read the lines being drawn in the sands and retired from the %companyname% while %they% still could. %They% took what money %they% had made and threw together a crew of thieves and brigands. Last you heard, %they% pulled off a perfect heist only for one of %their% partners to stab %them% in the back and take off with all the goods.";
		this.m.HiringCost = 95;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy)
		];
		this.m.Titles = [
			"the Shadow",
			"the Cutpurse",
			"the Snake",
			"the Raven",
			"the Burglar",
			"the Snatcher",
			"the Black Cat",
			"the Prince",
			"Quickfingers",
			"the Thief"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;


		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.BowTree
			],
			Defense = [
				::Const.Perks.ClothArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.MartyrTree,
				::Const.Perks.AgileTree,
				::Const.Perks.DeviousTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree,
				::Const.Perks.OutlawTree
			],
			Class = [
				::Const.Perks.ConArtistTree
			],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Pickpocket";
		this.m.Icon = "ui/backgrounds/pickpocket.png";
		this.m.BackgroundDescription = "A good pickpocket will have quick reflexes and the ability to evade any captors.";
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.NorthernFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()
	{
		return "{Raised by thieves on a diet of honeymilk and stolen gold, %name% started life off on the wrong foot. | Raised by a drunken father and an ill mother, %name% was parented straight into a life of thievery. | Born as the sixth-child of an already impoverished family, the budding thief %name% first learned the craft by stealing the last bits of dinner. | Growing up in a family servant to a rich noble, the eventual-thief %name% spent many years staring at royal opulence - and stealing from it. | Taken in by a local orphanage, it wasn\'t long for %name% to start taking abuse from the lowly orphans. %They% fell back on thieving to survive. | Orphaned, %name% grew up as a street urchin, %their% days governed by cutting purses and picking pockets. | While never particularly in need of money, %name%\'s jealousy over material things led %them% to thieving. | The profligacy of the rich amidst crowds of poor always rubbed %name% the wrong way. So %they% stole from them both and gave to %themselves%. | %name%\'s father taught %them% all there was to know about stealing including, unfortunately, how to backstab. | The church steals with a silver plate. The lords do it with the taxman. So %name% figured why can\'t %they% do it with %their% own two hands? | Impoverished while growing up, %name% took to stealing bread. Well-fed, %they% soon took to stealing crowns.} {After years of successful stealing, one mistake landed %name% in a dungeon. Thankfully, years of stealing also meant years of lockpicking and %they% didn\'t spend long. | But when %they% was caught trying to steal a temple\'s chalice, a talk with a priest convinced %name% to perhaps take a different path. | Unfortunately, a smash-and-grab at a local store ended with %name% being caught red-handed. %They% was soon profiled on posters everywhere, making %their% work difficult. | Daring to cut the purse of a fat trader, %name% soon found %themselves% nursing a hand absent of a few fingers. %They% really liked those fingers, too. | %name%\'s thievery eventually placed %them% at the head of an entire guild. But after a dozen failed assassination attempts, the thief realized there was nobody to trust in %their% line of work. | Partnering up with a beautiful woman, %name% managed to steal from everybody. Too bad the woman stole from %them%, in the end. | Trying to sell some goods, a trusted fence turned out to be a traitorous informant. One bad pillory experience later and the thief was exiled from %randomtown%. | It was the perfect heist. That\'s all that is said about it. Now, %name% just needs to lay low. | Tortured by a rival gang, %they% came to miss a number of teeth, fingernails, and any drive to return to thieving. | %Their% time as a thief came to an end when, arrested, %they% spent five days pilloried during tomato season. | Naturally, it wasn\'t long until %they% went to prison. %They% doesn\'t speak of %their% time there, but it is obvious %they% wishes to never return. | But one day %they% learned there are much better ways to spin a blade for a coin than petty thievery. | But %their% half-brother was captured by a local gang, forcing the thief to find new ways to pay the hefty ransom. | But life as a brigand is not easy. Arrested for eating a chicken that was not %theirs%, the %person% forfeited two fingers and any will to keep thieving. | After a heist went south, the %person% fingered all %their% former partners to save %their% own hide. Now %they% can never go back to thieving.} {For all you know %name% is just using sellswords to hide behind. Regardless of %their% reasons, %they're% still going to have to earn %their% pay. | You recognize %name% from some posters.  Well, a %person% who has gotten this far without being caught must have some value. | With one hand, %name% twirls a blade between %their% fingers. With the other, %they% snags your purse. Impressive. Now give it back. | Years of thieving have made %name% adept at escaping trouble. | %name% has the skills to be a good mercenary, just be sure to watch your purse while around %them%. | You can\'t trust a %person% like %name%, but that attribute has plenty of company anyway. | Supposedly, somebody once shot an arrow at %name%. They missed, but the thief kept the feathers. | %name%\'s effort to join sellswords better not be a scheme to steal from your coffers. | Wanted posters say %name% is considered \'armed and dangerous\'. Perfect. | There are plenty of lawmen looking for %name%. Maybe you can get them to join, too.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-2,
				-3
			],
			Bravery = [
				5,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				-2,
				3
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				12,
				10
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.headscarf]
		]));

	}
});

