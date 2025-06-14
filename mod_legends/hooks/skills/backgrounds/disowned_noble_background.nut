::mods_hookExactClass("skills/backgrounds/disowned_noble_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.disowned_noble";
		this.m.Name = "Disowned Noble";
		this.m.Icon = "ui/backgrounds/background_08.png";
		this.m.BackgroundDescription = "Disowned nobles often have profited from some training in melee fighting at court.";
		this.m.GoodEnding = "A noble at heart, the disowned %noble% %name% returned to %their% family. Word has it %they% kicked in the doors and demanded a royal seat. An usurper challenged %them% in combat and, well, %name% learned a lot in %their% days with the %companyname% and %they% now sits on a very, very comfortable throne.";
		this.m.BadEnding = "A %person% of nobility at heart, %name% the disowned noble returned to %their% family home. Word has it an usurper arrested %them% at the gates. %Their% head currently rests on a pike with crows for a crown.";
		this.m.HiringCost = 135;
		this.m.DailyCost = 17;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles)
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
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Outlaw;
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

		this.m.Name = "Disowned Lady";
		this.m.Icon = "ui/backgrounds/background_08.png";
		this.m.BackgroundDescription = "Disowned ladies often have profited from some training in ranged warfare at court.";
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
				this.Const.Perks.AgileTree,
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

	o.onBuildDescription <- function ()
	{
		return "{A constant disappointment to a delusional father | A victim of court intrigue involving poison and cake | After openly denouncing %their% own heritage | After an incestous relationship with %their% brother came to light | After a coup to dispose %their% older %sibling% failed | After pride and hubris had %their% leading %their% father\'s army to total defeat | For accidentally killing %their% oldest brother and heir to the throne on a hunt | As a price to be paid for choosing %their% allies poorly in a war of succession | For attempting to sell captured poachers as slaves | Caught bedding a fellow noble%person% | Discovered to be the head of a child stealing plot that shocked the peasantry | For turning %their% back on the gods and causing a riot amongst the laymen | Seen with the cultists\' book of Davkul tucked under an arm}, %name% {was disowned and cast away from %their% family\'s estate, never to return. | was stripped of %their% titles and exiled from the land. | was forcibly removed from %their% land and told never to return. | came to see, by the threat of an executioner\'s axe, that %they% no longer belonged in the court. | saw the hangman\'s noose, and only by a clever ploy did %they% slip it. | was branded with the symbol of shame and cast out from %their% lands. | was believed to have been involved in one too many conspiracies and was removed from the lands. | was seen as being too ambitious, a dangerous trait amongst the nobility.} {%name% now seeks to redeem %themselves% and live up to the family name. A bit selfish for a mercenary outfit, noble nonetheless. | %Their% posture slumped by scandal, %name%\'s resistance to difficulties has diminished. | A skilled fighter %they% may be, but %name% rarely talks about anyone but %themselves%. | Though quick with a sword, you get the feeling someone like %name% was disowned for a reason. | Down on %their% luck and essentially broke, %name% ventures in the field of sellswords. | Without title or land, %name% seeks to join the sort of people %they% used to lord over. | Well-geared this former noble may be, you do notice that the most used piece of equipment %name% has are %their% boots.}";
	}

	o.onChangeAttributes = function ()
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

	o.onAddEquipment = function ()
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
				[1, ::Legends.Armor.Standard.padded_leather],
				[1, ::Legends.Armor.Standard.gambeson],
				[1, ::Legends.Armor.Standard.basic_mail_shirt],
				[1, ::Legends.Armor.Standard.mail_shirt],
				[1, ::Legends.Armor.Standard.mail_hauberk]
			]));

			items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.nasal_helmet],
				[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.mail_coif],
				[1, ::Legends.Helmet.Standard.feathered_hat],
				[3, ::Legends.Helmet.None]
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
				[1, ::Legends.Armor.Standard.padded_leather],
				[1, ::Legends.Armor.Standard.gambeson],
				[1, ::Legends.Armor.Standard.basic_mail_shirt],
				[1, ::Legends.Armor.Standard.mail_shirt],
				[1, ::Legends.Armor.Standard.mail_hauberk],
				[1, ::Legends.Armor.Standard.padded_surcoat]
			]));

			items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.nasal_helmet],
				[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.mail_coif],
				[1, ::Legends.Helmet.Standard.feathered_hat],
				[3, ::Legends.Helmet.None]
			]));
		}
	}
});
