this.legend_legion_gladiator_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_gladiator";
		this.m.Name = "Gladiator";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "A leader to few, a slave of many.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
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
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(4, 5);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2]; // 0.0, 0.1, 0.2, 0.3
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, //snow
				0.0, //badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				1.0, //desert
				1.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.PolearmTree,
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
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ButcherClassTree,
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.JugglerClassTree,
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
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{Although scarred and worn, %name% frequently stands out of place in the wider display of the legion. | After completing their contract at their gladiator school, %name% sought to apply their skills to the Legion. Eagerly accepted, they now seek to carve their name into the minds of their foes as well as fans. | Having been defeated in the arena, %name% believed their career to be over. After being found by the Legion however, a new opportunity for redemption and glory presents itself, one that will not be ignored. | %name% comes from one of the many imperial fighting pits, a slave-made-soldier in the blood sport industry. When the Legion came through, they saw the perfect opportunity to make a better name for themselves. | Killing can be made art in the right hands. %name% commanded the respect and admiration of much of the Empire at their zenith; now they serve the Legion, another faceless agent of carnage. | %name% led a once prestigious gladiator school, but time has since erased both from the world's memory. Now, they practice their trade of vicious combat in the rugged Legion, a far cry from days past. | The experience of fighting both man and beast has given %name% unique talents on the battlefield — preferring to trap their targets rather than forming shieldwalls or pike lines. | Despite the unusual methods of %name%, they fit well into the legion. | While different from the rest of the legion, %name% provides a skillset that many of the other legionaries could not hold a candle to.} {They prefer to wear a lighter set of armour, still dodging with uncanny speed despite their appearance. | Excelling at brutal and flashy bouts of violence, this gladiator is at home in the fighting pits. In the Legion, they will have to adapt their theatrical skills of arms if they hope to survive the harsher reality of real war. | Laying waste to beasts, slaves, and the condemned criminals of the empire, this gladiator boasts impressive martial skills, albeit with limited experience in larger scale combat. |  Better suited to dramatic and performative combat than rigid formation warfare, this gladiator promises a strong martial foundation, if they can adapt to life outside the pits. | Skilled in nets, lassos, whips, tridents, and other unconventional weapons of war, this gladiator presents a remarkable proficiency in adaptable combat. Whether they can transfer these skills to the Legion remains to be seen. | This imperial gladiator boasts intimate experience in slaying the myriad monsters of the world with ceremonial flair. Time will tell if their pit knowledge transfers well against human prey. | As the rest of the camp sharpens weapons, %they% fixes their nets for beasts and soldiers alike. | Often opting for unconventional weapons, %name% managed to fill a role within the legion that few can match, which is to say, working alone. | They have a habit of pacing around the camp\'s edge, watching for trespassers on two legs or more. | %name% has a supernatural amount in finesse about them, often outperforming their fellow fights in speed and precision.} {Years of training and hardship endure in what remains of them, even in death they are still little more than a slave. | On the whole, they are not far detached from the camp slaves or auxiliaries — often spending more time in quiet communion with them than the other groups. | Despite their clear strength, the years have taken a toll on them, showing confusion when claws of beasts do not draw blood, or jaws that would rip their skin merely clamp on their bones. | Boastful and loud, %name% practically demands attention at every moment. Perhaps forgetting their position in the Legion, they are quick to suffer reprimands from their superiors. | %name%'s hollow face shows a clear mourning for their old position in the fighting pits. When the order comes to fight, they put their old experience to use, perhaps remembering better days. | %name% spends much of their time in confused sparring matches against vanquished foes centuries past. Whether they believe themself still in the arena, or seeking a desperate attempt to relive old glories is uncertain. | Not all gladiators miss their old trade, and %name% seems to one of them. Eager to work with their new brothers in arms in collaboration instead of contest, they now fight and die for the Legion. | Perhaps lamenting the new chain of command they're beholden to, %name% appears crestfallen and underappreciated. While killing might be celebrated in the arena, in the Legion, it's just part of the job.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				20,
				30
			],
			Bravery = [ //not needed except for resisting charm and sleep
				5,
				10
			],
			Stamina = [ //not needed except for equipment weight
				10,
				15
			],
			MeleeSkill = [
				12,
				16
			],
			RangedSkill = [
				10,
				18
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				4,
				7
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
			[1, "weapons/ancient/ancient_spear"],
			[1, "weapons/throwing_spear"],
			[1, "weapons/ancient/legend_gladius"],
			[1, "weapons/ancient/legend_kopis"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			items.equip(::Const.World.Common.pickItem([
				[2, "tools/throwing_net"],
				[1, "shields/ancient/tower_shield"]
			], "scripts/items/"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[1, ::Legends.Armor.Standard.indebted_armor_rags],
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_gladiator_helmet]
		]));
	}
});
