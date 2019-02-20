this.female_thief_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_thief";
		this.m.Name = "Pickpocket";
		this.m.Icon = "ui/backgrounds/background_11.png";
		this.m.BackgroundDescription = "A good pickpocket will have quick reflexes and the ability to evade any captors.";
		this.m.GoodEnding = "%name% the pickpocket retired from fighting and disappeared off the map. You haven\'t heard word of the woman since, but there are rumors that a certain nobleman had one of his vaults completely drained in a perfectly executed heist.";
		this.m.BadEnding = "%name% the thief read the lines being drawn in the sands and retired from the %companyname% while she still could. She took what money she had made and threw together a crew of thieves and brigands. Last you heard, she pulled off a perfect heist only for one of her partners to stab her in the back and take off with all the goods.";
		this.m.HiringCost = 95;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.huge",
			"trait.teamplayer",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.paranoid",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.dumb",
			"trait.loyal",
			"trait.clumsy",
			"trait.fat",
			"trait.strong",
			"trait.hesitant",
			"trait.slow",
			"trait.insecure",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.brute",
			"trait.strong",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"the Shadow",
			"the Cutpurse",
			"the Snake",
			"the Raven",
			"the Burglar",
			"the Snatcher",
			"the Black Cat",
			"the Sneak",
			"Quickfingers",
			"the Thief"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Body = "bust_naked_body_03";
		this.m.IsLowborn = true;
		this.m.IsFemaleBackground = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{Raised by thieves on a diet of honeymilk and stolen gold, %name% started life off on the wrong foot. | Raised by a drunken father and an ill mother, %name% was parented straight into a life of thievery. | Born as the sixth-child of an already impoverished family, the budding thief %name% first learned the craft by stealing the last bits of dinner. | Growing up in a family servant to a rich noble, the eventual-thief %name% spent many years staring at royal opulence - and stealing from it. | Taken in by a local orphanage, it wasn\'t long for %name% to start taking abuse from the lowly orphans. She fell back on thieving to survive. | Orphaned, %name% grew up as a street urchin, her days governed by cutting purses and picking pockets. | While never particularly in need of money, %name%\'s jealousy over material things led her to thieving. | The profligacy of the rich amidst crowds of poor always rubbed %name% the wrong way. So she stole from them both and gave to herself. | %name%\'s father taught her all there was to know about stealing including, unfortunately, how to backstab. | The church steals with a silver plate. The lords do it with the taxman. So %name% figured why can\'t she do it with her own two hands? | Impoverished while growing up, %name% took to stealing bread. Well-fed, she soon took to stealing crowns.} {After years of successful stealing, one mistake landed %name% in a dungeon. Thankfully, years of stealing also meant years of lockpicking and she didn\'t spend long. | But when she was caught trying to steal a temple\'s chalice, a talk with a monk convinced %name% to perhaps take a different path. | Unfortunately, a smash-and-grab at a local store ended with %name% being caught red-handed. She was soon profiled on posters everywhere, making her work difficult. | Daring to cut the purse of a fat trader, %name% soon found herself nursing a hand absent of a few fingers. She really liked those fingers, too. | %name%\'s thievery eventually placed her at the head of an entire guild. But after a dozen failed assassination attempts, the thief realized there was nobody to trust in her line of work. | Partnering up with a beautiful woman, %name% managed to steal from everybody. Too bad the woman stole from her, in the end. | Trying to sell some goods, a trusted fence turned out to be a traitorous informant. One bad pillory experience later and the thief was exiled from %randomtown%. | It was the perfect heist. That\'s all that is said about it. Now, %name% just needs to lay low. | Tortured by a rival gang, she came to miss a number of teeth, fingernails, and any drive to return to thieving. | Her time as a thief came to an end when, arrested, she spent five days pilloried during tomato season. | Naturally, it wasn\'t long until she went to prison. She doesn\'t speak of his time there, but it is obvious she wishes to never return. | But one day she learned there are much better ways to spin a blade for a coin than petty thievery. | But her half-brother was captured by a local gang, forcing the thief to find new ways to pay the hefty ransom. | But life as a brigand is not easy. Arrested for eating a chicken that was not her, the woman forfeited two fingers and any will to keep thieving. | After a heist went south, the woman fingered all her former partners to save her own hide. Now she can never go back to thieving.} {For all you know %name% is just using sellswords to hide behind. Regardless of her reasons, she\'s still going to have to earn her pay. | You recognize %name% from some posters.  Well, a woman who has gotten this far without being caught must have some value. | With one hand, %name% twirls a blade between her fingers. With the other, she snags your purse. Impressive. Now give it back. | Years of thieving have made %name% adept at escaping trouble. | %name% has the skills to be a good mercenary, just be sure to watch your purse while around her. | You can\'t trust a woman like %name%, but that attribute has plenty of company anyway. | Supposedly, somebody once shot an arrow at %name%. They missed, but the thief kept the feathers. | %name%\'s effort to join sellswords better not be a scheme to steal from your coffers. | Wanted posters say %name% is considered \'armed and dangerous\'. Perfect. | There are plenty of lawmen looking for %name%. Maybe you can get them to join, too.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				5,
				0
			],
			Stamina = [
				5,
				5
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

	function onAddEquipment()
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

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
	}

});
