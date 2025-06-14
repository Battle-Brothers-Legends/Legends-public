::mods_hookExactClass("skills/backgrounds/eunuch_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.eunuch";
		this.m.Name = "Eunuch";
		this.m.Icon = "ui/backgrounds/background_52.png";
		this.m.BackgroundDescription = "The fact that eunuchs can\'t sire children is probably a secondary concern for a mercenary company.";
		this.m.GoodEnding = "For %name%, some things would just always come up a little short. But that didn\'t stop the eunuch from enjoying himself. Retiring from the %companyname% with a large pile of crowns, and completely devoid of the allures of women, the man went on to live a wonderful, extremely focused life.";
		this.m.BadEnding = "It\'s said that %name% the eunuch departed from the company shortly after you did. He traveled the lands, broke and broken, wasting his scant crowns on ale and wenches. Insulted by a whore for his cockless nature, the drunken and enraged eunuch stabbed the woman in the eye with a goat horn. Still inebriated when the constable found him, the confused and bewildered eunuch was stripped, hanged, and mutilated by the townspeople before having his body fed to pigs.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Impatient)
		];
		this.m.Titles = [
			"the Eunuch",
			"the Gelding"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated | this.Const.BackgroundType.Performing;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.MaceTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.MartyrTree
			],
			Enemy = [],
			Class = [],
			Profession = [
				this.Const.Perks.BarterProfessionTree
			], 
			Magic = []
		}

	}
	
	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onBuildDescription <- function ()
	{
		return "{When %name% was just a boy, a local clergymen castrated him so that his voice could carry a higher pitch in the local choir. | When raiders invaded his village, %name% fought back only for his cock and balls to be cut from his body as punishment. | Accused of a heinous crime in the bed of an unwanting woman, %name% had the option of death or living life as a eunuch. You don\'t need physical evidence to know which one he chose. | Once a monk in training, it is said that %name% bedded a woman of another faith. He was kicked out of the faith and, in an attempt to regain their sympathies, the man removed the offending \'equipment.\' It appears the faithful did not welcome him back. | As a child, %name%\'s drunkard {mother | father | elder sister | elder brother} took a {hot pan | jagged knife} {to his cock while he slept | to his cock as a form of vicious torture}. | When %name% was traversing the forests not far from %townname%, he was attacked by a wild {boar | bear | dog | hawk} which tore great strands of flesh from his body. Surviving, he eventually realized the beast had castrated him, too. | %name% hails from the whorehouses of %randomtown% where mutilation of his body was made to satisfy a particular customer\'s requests.} {The man was adrift when you ran across him. Now, it just seems like he wants to get away from the world, even if it means joining {sellswords | mercenaries}. Though his plight is not one you would wish upon anyone, he is a rather calm fellow. | You found the man being bullied by kids when you found him. Seeing your sword, he politely asked to join your band of men where one\'s past, or physical deformities, do not matter. He is already used to life\'s struggles, perhaps in a way most men can\'t speak to. | Surprisingly, the man stands straighter than most. He looks rather calm and collected for man who has had something so dear to him removed. | While the horrors of the man\'s past raise your hairs, and lower your nether regions into nearly being tucked, the eunuch seems unbothered by what has happened to him. He is a calm, almost passive figure. | The man has more stoicism in his movements than most monks you\'ve seen. He seems at peace with his calamitous past. | No longer able to satiate his carnal desires, the man seems rather pacified and calm. Resolute, even, and seeing more in the world than what its physical appearances might initially offer.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				5,
				7
			],
			Stamina = [
				0,
				0
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
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));
	}
});