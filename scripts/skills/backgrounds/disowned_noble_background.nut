this.disowned_noble_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.disowned_noble";
		this.m.Name = "Disowned Noble";
		this.m.Icon = "ui/backgrounds/background_08.png";
		this.m.BackgroundDescription = "Disowned nobles often have profited from some training in melee fighting at court.";
		this.m.GoodEnding = "A noble at heart, the disowned nobleman %name% returned to his family. Word has it he kicked in the doors and demanded a royal seat. An usurper challenged him in combat and, well, %name% learned a lot in his days with the %companyname% and he now sits on a very, very comfortable throne.";
		this.m.BadEnding = "A man of nobility at heart, %name% the disowned noble returned to his family home. Word has it an usurper arrested him at the gates. His head currently rests on a pike with crows for a crown.";
		this.m.HiringCost = 135;
		this.m.DailyCost = 17;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.clumsy",
			"trait.fragile",
			"trait.spartan",
			"trait.clubfooted",
			"trait.legend_hate_nobles"
		];
		this.m.Titles = [
			"the Disowned",
			"the Exiled",
			"the Disgraced"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Educated | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Outlaw;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.MartyrTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree
			],
			Class = [],
			Magic = []
		}
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		if (_gender != 1) return;

		this.m.Name = "Adventurous Lady";
		this.m.Icon = "ui/backgrounds/adventurous_noble_woman.png";
		this.m.BackgroundDescription = "Adventurous Ladies tend to have high resolve and ranged skills, but often neglect melee defense.";
		this.m.GoodEnding = "Adventurousness never leaves the soul of a woman like %name%. {Instead of returning to her noble family, she left the %companyname% and headed east in search of rare beasts. Word has it she returned to town with the head of what looked like a giant lizard, but you don\'t believe such fantastical tripe. | She departed the %companyname% and ventured west, sailing across the oceans to unseen lands. There\'s no telling where he is these days, but you\'ve little doubt that he\'ll be coming back with stories to tell. | She retired from the %companyname% and, instead of returning to her noble family, headed south. Word has it she fought in a great noble civil war, killed an orc warlord, climbed the highest mountain in the land, and is currently writing an epic about her travels. | The noblewoman left the %companyname% and, preferring the life of adventure to noble boredom, she headed north. Word has it that she\'s currently marching a troop of explorers to the furthest reaches of the world.}";
		this.m.BadEnding = "%name% departed the %companyname% and continued her adventuring elsewhere. {She headed east, hoping to discover the source of the greenskins, but the noblewoman has not been heard from since. | She headed north into the snowy wastes. Word has it she was seen a week ago, marching south this time, looking rather pale and shuffling moreso than walking. | She headed south into brutal marshlands. Word has it that a mysterious flame appeared in the fog and she walked toward it. The men who saw this said she disappeared into the mist and never returned. | She headed west and sailed the open sea. Despite having no experience at sea, she saw fit to make herself captain of the boat. They say pieces of her ship and dead sailors kept washing ashore for weeks.}";

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.BowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [
				this.Const.Perks.ArchersTree
			],
			Class = [],
			Magic = []
		}
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{A constant disappointment to a delusional father | A victim of court intrigue involving poison and cake | After openly denouncing her own heritage | After an incestous relationship with her brother came to light | After a coup to dispose her older sister failed | After pride and hubris had her leading her father\'s army to total defeat | For accidentally killing her oldest brother and heir to the throne on a hunt | As a price to be paid for choosing her allies poorly in a war of succession | For attempting to sell captured poachers as slaves | Caught bedding a fellow noblewoman | Discovered to be the head of a child stealing plot that shocked the peasantry | For turning her back on the gods and causing a riot amongst the laymen | Seen with the cultists\' book of Davkul tucked under an arm}, %name% {was disowned and cast away from her family\'s estate, never to return. | was stripped of her titles and exiled from the land. | was forcibly removed from her land and told never to return. | came to see, by the threat of an executioner\'s axe, that she no longer belonged in the court. | saw the hangman\'s noose, and only by a clever ploy did she slip it. | was branded with the symbol of shame and cast out from her lands. | was believed to have been involved in one too many conspiracies and was removed from the lands. | was seen as being too ambitious, a dangerous trait amongst the nobility.} {%name% now seeks to redeem herself and live up to the family name. A bit selfish for a mercenary outfit, noble nonetheless. | Her posture slumped by scandal, %name%\'s resistance to difficulties has diminished. | A skilled fighter she may be, but %name% rarely talks about anyone but herself. | Though quick with a sword, you get the feeling someone like %name% was disowned for a reason. | Down on her luck and essentially broke, %name% ventures in the field of sellswords. | Without title or land, %name% seeks to join the sort of men she used to lord over. | Well-geared this former noble may be, you do notice that the most used piece of equipment %name% has are her boots.}";
		}
		else
		{
			return "{A constant disappointment to a delusional father | A victim of court intrigue involving poison and cake | After openly denouncing %their% own heritage | After an incestous relationship with %their% brother came to light | After a coup to dispose %their% older sister failed | After pride and hubris had %their% leading %their% father\'s army to total defeat | For accidentally killing %their% oldest brother and heir to the throne on a hunt | As a price to be paid for choosing %their% allies poorly in a war of succession | For attempting to sell captured poachers as slaves | Caught bedding a fellow noble%person% | Discovered to be the head of a child stealing plot that shocked the peasantry | For turning %their% back on the gods and causing a riot amongst the laymen | Seen with the cultists\' book of Davkul tucked under an arm}, %name% {was disowned and cast away from %their% family\'s estate, never to return. | was stripped of %their% titles and exiled from the land. | was forcibly removed from %their% land and told never to return. | came to see, by the threat of an executioner\'s axe, that %they% no longer belonged in the court. | saw the hangman\'s noose, and only by a clever ploy did %they% slip it. | was branded with the symbol of shame and cast out from %their% lands. | was believed to have been involved in one too many conspiracies and was removed from the lands. | was seen as being too ambitious, a dangerous trait amongst the nobility.} {%name% now seeks to redeem %themselves% and live up to the family name. A bit selfish for a mercenary outfit, noble nonetheless. | %Their% posture slumped by scandal, %name%\'s resistance to difficulties has diminished. | A skilled fighter %they% may be, but %name% rarely talks about anyone but %themselves%. | Though quick with a sword, you get the feeling someone like %name% was disowned for a reason. | Down on %their% luck and essentially broke, %name% ventures in the field of sellswords. | Without title or land, %name% seeks to join the sort of people %they% used to lord over. | Well-geared this former noble may be, you do notice that the most used piece of equipment %name% has are %their% boots.}";
		}
	}

	function onChangeAttributes()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return {
				Hitpoints = [
					-2,
					3
				],
				Bravery = [
					-6,
					-1
				],
				Stamina = [
					-10,
					-5
				],
				MeleeSkill = [
					0,
					10
				],
				RangedSkill = [
					5,
					15
				],
				MeleeDefense = [
					-3,
					2
				],
				RangedDefense = [
					0,
					5
				],
				Initiative = [
					5,
					10
				]
			};
		}
		else
		{
			return {
				Hitpoints = [
					-2,
					3
				],
				Bravery = [
					-6,
					-1
				],
				Stamina = [
					-10,
					-5
				],
				MeleeSkill = [
					5,
					15
				],
				RangedSkill = [
					0,
					10
				],
				MeleeDefense = [
					-1,
					4
				],
				RangedDefense = [
					-2,
					3
				],
				Initiative = [
					-5,
					5
				]
			};
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/hunting_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/light_crossbow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
				items.equip(this.new("scripts/items/shields/wooden_shield"));
			}


			items.equip(this.Const.World.Common.pickArmor([
				[1, "padded_leather"],
				[1, "gambeson"],
				[1, "basic_mail_shirt"],
				[1, "mail_shirt"],
				[1, "mail_hauberk"]
			]))

			items.equip(this.Const.World.Common.pickHelmet([
				[1, "nasal_helmet"],
				[1, "padded_nasal_helmet"],
				[1, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "mail_coif"],
				[1, "feathered_hat"],
				[3, ""]
			]));
		}
		else
		{
			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/militia_spear"));
			}

			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/shields/wooden_shield"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/shields/buckler_shield"));
			}

			items.equip(this.Const.World.Common.pickArmor([
				[1, "padded_leather"],
				[1, "gambeson"],
				[1, "basic_mail_shirt"],
				[1, "mail_shirt"],
				[1, "mail_hauberk"],
				[1, "padded_surcoat"]
			]));

			items.equip(this.Const.World.Common.pickHelmet([
				[1, "nasal_helmet"],
				[1, "padded_nasal_helmet"],
				[1, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "mail_coif"],
				[1, "feathered_hat"],
				[3, ""]
			]));
		}
	}


	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "basic_mail_shirt"],
			[1, "mail_shirt"],
			[1, "mail_hauberk"],
			[1, "padded_surcoat"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "nasal_helmet"],
			[1, "padded_nasal_helmet"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "mail_coif"],
			[1, "feathered_hat"],
			[3, ""]
		]));

	}
});

