this.female_thief_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_thief";
		this.m.Name = "Pickpocket";
		this.m.Icon = "ui/backgrounds/pickpocket.png";
		this.m.BackgroundDescription = "A good pickpocket will have quick reflexes and the ability to evade any captors.";
		this.m.GoodEnding = "%name% the pickpocket retired from fighting and disappeared off the map. You haven\'t heard word of the woman since, but there are rumors that a certain nobleman had his pockets completely drained in broad daylight during a public address.";
		this.m.BadEnding = "%name% the thief read the lines being drawn in the sands and retired from the %companyname% while she still could. She took what money she had made and threw together a crew of thieves and brigands. Last you heard, she pulled off a perfect theft only for one of her partners to stab her in the back and take off with all the goods.";
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
			"the Decoy",
			"the Disguised",
			"the Cloak",
			"Night Raven",
			"the Charade",
			"the Cunning",
			"the Black Cat",
			"the Sneak",
			"Quickfingers",
			"the Veil"
		];
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Body = "bust_naked_body_03";
		this.m.IsFemaleBackground = true;
		this.m.IsLowborn = true;
		this.m.IsOutlawBackground = true;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FastTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree,
				this.Const.Perks.MercenaryTree
				],
			Class = [this.Const.Perks.KnifeClassTree]
		}
	}

	//Default Female
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 1;
			if (this.Const.LegendMod.Configs.LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r == 1)
		{
			return
		}
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Body = "bust_naked_body_00";
		this.m.BeardChance = 50;
		this.m.IsFemaleBackground = false;
		this.m.BackgroundDescription = "A good thief will have quick reflexes and the ability to evade any captors.";
		this.m.GoodEnding = "%name% the pickpocket retired from fighting and disappeared off the map. You haven\'t heard word of the man since, but there are rumors that a certain nobleman had one of his pockets completely drained in broad daylight during a public address.";
		this.m.BadEnding = "%name% the pickpocket read the lines being drawn in the sands and retired from the %companyname% while he still could. He took what money he had made and threw together a crew of thieves and brigands. Last you heard, he pulled off a perfect heist only for one of his partners to stab him in the back and take off with all the goods.";

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
		if (this.m.IsFemaleBackground == true)
		{
			return "{Raised by thieves on a diet of honeymilk and stolen gold, %name% started life off on the wrong foot. | Raised by a drunken father and an ill mother, %name% was parented straight into a life of thievery. | Born as the sixth-child of an already impoverished family, the budding thief %name% first learned the craft by stealing the last bits of dinner. | Growing up in a family servant to a rich noble, the eventual-thief %name% spent many years staring at royal opulence - and stealing from it. | Taken in by a local orphanage, it wasn\'t long for %name% to start taking abuse from the lowly orphans. She fell back on thieving to survive. | Orphaned, %name% grew up as a street urchin, her days governed by cutting purses and picking pockets. | While never particularly in need of money, %name%\'s jealousy over material things led her to thieving. | The profligacy of the rich amidst crowds of poor always rubbed %name% the wrong way. So she stole from them both and gave to herself. | %name%\'s father taught her all there was to know about stealing including, unfortunately, how to backstab. | The church steals with a silver plate. The lords do it with the taxman. So %name% figured why can\'t she do it with her own two hands? | Impoverished while growing up, %name% took to stealing bread. Well-fed, she soon took to stealing crowns.} {After years of successful stealing, one mistake landed %name% in a dungeon. Thankfully, years of stealing also meant years of lockpicking and she didn\'t spend long. | But when she was caught trying to steal a temple\'s chalice, a talk with a monk convinced %name% to perhaps take a different path. | Unfortunately, a smash-and-grab at a local store ended with %name% being caught red-handed. She was soon profiled on posters everywhere, making her work difficult. | Daring to cut the purse of a fat trader, %name% soon found herself nursing a hand absent of a few fingers. She really liked those fingers, too. | %name%\'s thievery eventually placed her at the head of an entire guild. But after a dozen failed assassination attempts, the thief realized there was nobody to trust in her line of work. | Partnering up with a beautiful woman, %name% managed to steal from everybody. Too bad the woman stole from her, in the end. | Trying to sell some goods, a trusted fence turned out to be a traitorous informant. One bad pillory experience later and the thief was exiled from %randomtown%. | It was the perfect heist. That\'s all that is said about it. Now, %name% just needs to lay low. | Tortured by a rival gang, she came to miss a number of teeth, fingernails, and any drive to return to thieving. | Her time as a thief came to an end when, arrested, she spent five days pilloried during tomato season. | Naturally, it wasn\'t long until she went to prison. She doesn\'t speak of his time there, but it is obvious she wishes to never return. | But one day she learned there are much better ways to spin a blade for a coin than petty thievery. | But her half-brother was captured by a local gang, forcing the thief to find new ways to pay the hefty ransom. | But life as a brigand is not easy. Arrested for eating a chicken that was not her, the woman forfeited two fingers and any will to keep thieving. | After a heist went south, the woman fingered all her former partners to save her own hide. Now she can never go back to thieving.} {For all you know %name% is just using sellswords to hide behind. Regardless of her reasons, she\'s still going to have to earn her pay. | You recognize %name% from some posters.  Well, a woman who has gotten this far without being caught must have some value. | With one hand, %name% twirls a blade between her fingers. With the other, she snags your purse. Impressive. Now give it back. | Years of thieving have made %name% adept at escaping trouble. | %name% has the skills to be a good mercenary, just be sure to watch your purse while around her. | You can\'t trust a woman like %name%, but that attribute has plenty of company anyway. | Supposedly, somebody once shot an arrow at %name%. They missed, but the thief kept the feathers. | %name%\'s effort to join sellswords better not be a scheme to steal from your coffers. | Wanted posters say %name% is considered \'armed and dangerous\'. Perfect. | There are plenty of lawmen looking for %name%. Maybe you can get them to join, too.}";
		}
		else
		{
			return "{Raised by thieves on a diet of honeymilk and stolen gold, %name% started life off on the wrong foot. | Raised by a drunken father and an ill mother, %name% was parented straight into a life of thievery. | Born as the sixth-child of an already impoverished family, the budding thief %name% first learned the craft by stealing the last bits of dinner. | Growing up in a family servant to a rich noble, the eventual-thief %name% spent many years staring at royal opulence - and stealing from it. | Taken in by a local orphanage, it wasn\'t long for %name% to start taking abuse from the lowly orphans. He fell back on thieving to survive. | Orphaned, %name% grew up as a street urchin, his days governed by cutting purses and picking pockets. | While never particularly in need of money, %name%\'s jealousy over material things led him to thieving. | The profligacy of the rich amidst crowds of poor always rubbed %name% the wrong way. So he stole from them both and gave to himself. | %name%\'s father taught him all there was to know about stealing including, unfortunately, how to backstab. | The church steals with a silver plate. The lords do it with the taxman. So %name% figured why can\'t he do it with his own two hands? | Impoverished while growing up, %name% took to stealing bread. Well-fed, he soon took to stealing crowns.} {After years of successful stealing, one mistake landed %name% in a dungeon. Thankfully, years of stealing also meant years of lockpicking and he didn\'t spend long. | But when he was caught trying to steal a temple\'s chalice, a talk with a monk convinced %name% to perhaps take a different path. | Unfortunately, a smash-and-grab at a local store ended with %name% being caught red-handed. He was soon profiled on posters everywhere, making his work difficult. | Daring to cut the purse of a fat trader, %name% soon found himself nursing a hand absent of a few fingers. He really liked those fingers, too. | %name%\'s thievery eventually placed him at the head of an entire guild. But after a dozen failed assassination attempts, the thief realized there was nobody to trust in his line of work. | Partnering up with a beautiful woman, %name% managed to steal from everybody. Too bad the woman stole from him, in the end. | Trying to sell some goods, a trusted fence turned out to be a traitorous informant. One bad pillory experience later and the thief was exiled from %randomtown%. | It was the perfect heist. That\'s all that is said about it. Now, %name% just needs to lay low. | Tortured by a rival gang, he came to miss a number of teeth, fingernails, and any drive to return to thieving. | His time as a thief came to an end when, arrested, he spent five days pilloried during tomato season. | Naturally, it wasn\'t long until he went to prison. He doesn\'t speak of his time there, but it is obvious he wishes to never return. | But one day he learned there are much better ways to spin a blade for a coin than petty thievery. | But his half-brother was captured by a local gang, forcing the thief to find new ways to pay the hefty ransom. | But life as a brigand is not easy. Arrested for eating a chicken that was not his, the man forfeited two fingers and any will to keep thieving. | After a heist went south, the man fingered all his former partners to save his own hide. Now he can never go back to thieving.} {For all you know %name% is just using sellswords to hide behind. Regardless of his reasons, he\'s still going to have to earn his pay. | You recognize %name% from some posters.  Well, a man who has gotten this far without being caught must have some value. | With one hand, %name% twirls a blade between his fingers. With the other, he snags your purse. Impressive. Now give it back. | Years of thieving have made %name% adept at escaping trouble. | %name% has the skills to be a good mercenary, just be sure to watch your purse while around him. | You can\'t trust a man like %name%, but that attribute has plenty of company anyway. | Supposedly, somebody once shot an arrow at %name%. They missed, but the thief kept the feathers. | %name%\'s effort to join sellswords better not be a scheme to steal from your coffers. | Wanted posters say %name% is considered \'armed and dangerous\'. Perfect. | There are plenty of lawmen looking for %name%. Maybe you can get them to join, too.}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-7,
				-2
			],
			Bravery = [
				5,
				0
			],
			Stamina = [
				8,
				3
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				5,
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

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.m.IsFemaleBackground == true)
		{
			actor.setName(this.Const.Strings.CharacterNamesFemale[this.Math.rand(0, this.Const.Strings.CharacterNamesFemale.len() - 1)]);
		}
		else
		{
			actor.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		}
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

		r = this.Math.rand(0, 3);

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
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/legend_maid_dress"));
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

	function onAddLegendEquipment()
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


		local cloths = [
            [0, ""],
			[0, "cloth/legend_gambeson"],
			[0, "cloth/legend_gambeson_plain"],
			[0, "cloth/legend_gambeson_wolf"],
			[0, "cloth/legend_padded_surcoat"],
			[0, "cloth/legend_robes"],
			[0, "cloth/legend_apron_butcher"],
			[0, "cloth/legend_robes_nun"],
			[0, "cloth/legend_apron_smith"],
			[0, "cloth/legend_robes_wizard"],
			[1, "cloth/legend_sackcloth"],
			[0, "cloth/legend_sackcloth_patched"],
			[0, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_tunic"],
			[0, "cloth/legend_tunic_noble"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths)

		if (armor != null)
		{
			local chains = [
                [0, ""],
                [0, "chain/legend_armor_mail_shirt"],
				[0, "chain/legend_armor_mail_shirt_simple"],
				[0, "chain/legend_armor_rusty_mail_shirt"],
				[0, "chain/legend_armor_ancient_double_mail"],
				[0, "chain/legend_armor_ancient_mail"],
				[0, "chain/legend_armor_basic_mail"],
				[0, "chain/legend_armor_hauberk"],
				[0, "chain/legend_armor_hauberk_full"],
				[0, "chain/legend_armor_hauberk_sleevless"],
				[0, "chain/legend_armor_reinforced_mail"],
				[0, "chain/legend_armor_reinforced_mail_shirt"],
				[0, "chain/legend_armor_reinforced_rotten_mail_shirt"],
				[0, "chain/legend_armor_reinforced_worn_mail"],
				[0, "chain/legend_armor_reinforced_worn_mail_shirt"],
				[0, "chain/legend_armor_short_mail"]
			]

			local chain = this.Const.World.Common.pickLegendArmor(chains)
			if (chain != null)
			{
				armor.setUpgrade(chain)
			}

			local plates = [
                [2, ""],
				[0, "plate/legend_armor_leather_brigandine"],
				[0, "plate/legend_armor_leather_brigandine_hardened"],
				[0, "plate/legend_armor_leather_brigandine_hardened_full"],
				[1, "plate/legend_armor_leather_jacket"],
				[1, "plate/legend_armor_leather_jacket_simple"],
				[0, "plate/legend_armor_leather_lamellar"],
				[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
				[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
				[0, "plate/legend_armor_leather_lamellar_heavy"],
				[0, "plate/legend_armor_leather_lamellar_reinforced"],
				[0, "plate/legend_armor_leather_noble"],
				[0, "plate/legend_armor_leather_padded"],
				[0, "plate/legend_armor_leather_riveted"],
				[0, "plate/legend_armor_leather_riveted_light"],
				[0, "plate/legend_armor_leather_scale"],
				[0, "plate/legend_armor_plate_ancient_chest"],
				[0, "plate/legend_armor_plate_ancient_harness"],
				[0, "plate/legend_armor_plate_ancient_mail"],
				[0, "plate/legend_armor_plate_ancient_scale"],
				[0, "plate/legend_armor_plate_ancient_scale_coat"],
				[0, "plate/legend_armor_plate_ancient_scale_harness"],
				[0, "plate/legend_armor_plate_chest"],
				[0, "plate/legend_armor_plate_chest_rotten"],
				[0, "plate/legend_armor_plate_cuirass"],
				[0, "plate/legend_armor_plate_full"],
				[0, "plate/legend_armor_scale"],
				[0, "plate/legend_armor_scale_coat"],
				[0, "plate/legend_armor_scale_coat_rotten"],
				[0, "plate/legend_armor_scale_shirt"]
			]
			local plate = this.Const.World.Common.pickLegendArmor(plates)
			if (plate != null)
			{
				armor.setUpgrade(plate)
			}

			items.equip(armor);
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
