this.legend_legion_auxiliary_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_auxiliary";
		this.m.Name = "Auxiliary";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "Pressed onto service by some means or another, the Auxiliary serves their masters in exchange of a promise for a better life.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			// this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		];

		//apperance
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		//---
		this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.Names = this.Const.Strings.AncientDeadNames;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(1, 2);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		// this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.07, //plains
				0.03, //swamp
				0.04, //hills
				0.05, //forest
				0.05, //forest
				0.05, //forest_leaves
				0.05, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.07, //farmland
				0.04, //snow
				0.04, //badlands
				0.04, //highlands
				0.04, //stepps
				0.0, //ocean
				0.07, //desert
				0.07 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.SpearfisherClassTree
			],
			Profession = [],
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
		this.m.Names = this.Const.Strings.AncientDeadNamesFemale;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		// return "{%name%} {hails from a far-off land, | comes from a distant place, | visits from not far way, | arrived from the far south, | journeyed from the east, | found themselves here from the north,} {a land surrounded by lakes and mountains as far as the eye could see | a land potted with bogs and trees | an area marked with tall trees and dense thickets | a land marked with scarred landscapes | a place considered to be a green paradise | a land filled with strife and war.} {Taken at a young age, | Taken at an old age,} {they were conscripted into a legion and made to fight. | they took to being a slave and later a legionary when their master died.} {Much was promised to them, including a way to escape their servitude. | Promises were made that given a few harvests more, they could return home.} {Much time has passed as a blur. %name% quietly wonders what their home looks like now, you wonder if it ever existed at all. | Some time has passed since this all transpired, much has changed. %name% has not, outside of the obvious.}";

		return "{Having been recruited by the Legion after falling to a plague, %name% believed their fighting days were soundly finished. Now, new battles await, and this call to violence cannot be refused. | %name% is no stranger to battle considering the myriad cuts, crushes, and fractures that dot their husked frame. While death may grant reprieve for some, in the Legion, it merely ensures your everlasting service. | Death in battle is no excuse to rest, and %name% knows this all too well. Being pressed into the Legion\'s auxiliary ranks, a violent destruction is all but assured unless their knowledge of wars past guides them through another day. | Brought in under the illusion of imperial citizenship and the promise of steady work, %name% know finds themselves an agent of the Legion\'s restless war machine, the completion of their service always one more campaign away | Dragged from their restful death, %name% fills the unenviable role of a front line skirmisher in the resurgent legion. Now a new lifetime of war and carnage await, with them tossed into the maelstrom at the Emperor\'s command.} {Skilled in various forms of combat, this auxiliary is pressed to bolster the legion\'s ranks through skirmishes and mixed support. Whether they \'survive\' to fight another day is frankly optional. | Primed to fill gaps in the frontlines, the role of an auxiliary is often short-lived and underappreciated, if they make it out intact, a new battle is always on the horizon. | Scouting, mapping, trapping, and killing- the work of an imperial auxiliary is one of constant peril and exertion. Should one survive an ordeal, a fresh danger always lingers behind every tree and over every hill, for the empire\'s enemies are plentiful and relentless. | Often sent in waves of bone and bronze to buy opportunities for more valuable troops, auxiliaries can depend on receiving the most dangerous orders, with little interest as to their success or destruction. If they kill a foe or two, even better, if not, there are always more bodies. | The first to fight and often to fall, auxiliaries are routinely used to probe enemy formations to find weaknesses for more important soldiers, often boasting strong skirmishing skills. While some find success on the frontlines, most are expected to soften the enemy before their inevitable destruction.} {Though they have heard little of this legion or the emperor it serves, %name% now serves through a confused mix of fear and admiration for their work, and hopes to carve out a better status within it. The horrors of their doomed station have not yet dawned on them, or perhaps they are simply wilfully blind to them. | Seemingly undisturbed by their station or the perils it entails, %name% wields a drive and thoroughness that would undoubtedly secure advancement anywhere else in the legion. At the front however, they might be lucky to last half a campaign... | If %name% still had flesh to plaster their cracked skull, it would undoubtedly paint a face of terror for all to see. The prospect of death in battle or at the hands of disappointed superiors disturbs this auxiliary on the regular, driving them to more reckless fights in hopes of escaping this cycle of horror. | An ardent believer in the empire and legion\'s mission, %auxiliary% hopes that their brief stint in the auxiliary troop will ensure their recognition and swift promotion to a station that befits their loyalty. Whether they make it that far remains to be seen... | Nervous and ever paranoid that they are being judged by their peers, %auxiliary% makes up for a lifetime of indecision through reckless abandon for their new unlife, seeking to prove themself and make the best of their peculiar new position within the legion.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				-1,
				4
			],
			Bravery = [ //not needed except for resisting charm and sleep
				0,
				5
			],
			Stamina = [ //not needed except for equipment weight
				10,
				10
			],
			MeleeSkill = [
				1,
				3
			],
			RangedSkill = [
				9,
				14
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				1,
				4
			],
			Initiative = [
				20,
				30
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command");  //justfies if this background is subject to the legion command skill
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on skeletons to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(::Const.World.Common.pickItem([
			[1, "weapons/throwing_spear"],
			[1, "weapons/ancient/falx"],
			[1, "weapons/ancient/ancient_spear"],
			[1, "weapons/ancient/ancient_sword"],
			[1, "weapons/ancient/broken_ancient_sword"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			if (this.Math.rand(1, 100) <= 50) {
				items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Standard.leather_wraps],
			[3, ::Legends.Armor.Standard.indebted_armor_rags],
			[2, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[3, ::Legends.Armor.None]
		]));

		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_household_helmet],
			[2, ::Legends.Helmet.None]
		]));
	}
});
