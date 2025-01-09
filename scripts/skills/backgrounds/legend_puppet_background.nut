this.legend_puppet_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_puppet";
		this.m.Name = "Puppet";
		this.m.Icon = "ui/backgrounds/background_puppet.png";
		this.m.BackgroundDescription = "A corpse in varying forms of decay. While slow on the uptake, it makes for a frightening opponent to most. You can also pick any name you like!";
		this.m.GoodEnding = "There is no beginning or end for %name%. Like any feral animal they simply wander around - occasionally following hordes of like minded dead, being adopted by a new master and slain, only to get back up again and wander some more. %name% repeats this cycle until one day the blow will be fatal. Is this a curse of a blessing? To cheat death is such a manner many would kill for. But %name% does not care. There is only hunger.";
		this.m.BadEnding = "There is no beginning or end for %name%. Like any feral animal they simply wander around - occasionally following hordes of like minded dead, being adopted by a new master and slain, only to get back up again and wander some more. %name% repeats this cycle until one day the blow will be fatal. Is this a curse of a blessing? To cheat death is such a manner many would kill for. But %name% does not care. There is only hunger.";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [ //can roll; brute, clubfooted, clumsy, fragile, huge, hesitant, strong, sure footing, survivor, tiny, tough, gluttonous, lucky, shortsighted, aggressive, martial, predictable, lumbering.
			"trait.ailing", //only including naturally occouring or obtainable traits.
			"trait.asthmatic",
			"trait.bleeder",
			"trait.bloodthirsty",
			"trait.brave",
			"trait.bright",
			"trait.cocky",
			"trait.craven",
			"trait.dastard",
			"trait.deathwish",
			"trait.determined",
			"trait.dexterous",
			"trait.disloyal",
			"trait.drunkard",
			"trait.dumb",
			"trait.fainthearted",
			"trait.fat",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_beasts",
			"trait.fearless",
			"trait.eagle_eyes",
			"trait.greedy",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.impatient",
			"trait.insecure",
			"trait.iron_lungs",
			"trait.iron_jaw",
			"trait.irrational",
			"trait.loyal",
			"trait.night_owl",
			"trait.night_blind",
			"trait.optimist",
			"trait.paranoid",
			"trait.pessimist",
			"trait.quick",
			"trait.spartan",
			"trait.superstitious",
			"trait.swift",
			"trait.teamplayer",
			"trait.weasel",
			//legend traits
			"trait.legend_ambitious",
			"trait.legend_fear_nobles",
			"trait.legend_hate_nobles",
			"trait.legend_frail",
			//"trait.legend_cannibalistic",
			"trait.legend_steady_hands",
			"trait.talented",
			"trait.legend_pragmatic",
			"trait.legend_unpredictable",
			"trait.legend_slack",
			"trait.legend_sureshot",
			"trait.legend_double_tongued",
			"trait.legend_gift_of_people",
			"trait.legend_seductive"
		];

		/*this.m.ExcludedTalents = [ //talentless
			this.Const.Attributes.Hitpoints
			this.Const.Attributes.Fatigue
			this.Const.Attributes.Bravery
			this.Const.Attributes.Initiative
			this.Const.Attributes.MeleeSkill
			this.Const.Attributes.RangedSkill
			this.Const.Attributes.MeleeDefense
			this.Const.Attributes.RangedDefense
		];*/

		//apperance
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		//---
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
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
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [],
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
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "There is no beginning or end for %name%. Like any feral animal they simply wander around - occasionally following hordes of like minded dead, being adopted by a new master and slain, only to get back up again and wander some more. %name% repeats this cycle until one day the blow will be fatal. Is this a curse of a blessing? To cheat death is such a manner many would kill for. But %name% does not care. There is only hunger.";
		this.m.BadEnding = "There is no beginning or end for %name%. Like any feral animal they simply wander around - occasionally following hordes of like minded dead, being adopted by a new master and slain, only to get back up again and wander some more. %name% repeats this cycle until one day the blow will be fatal. Is this a curse of a blessing? To cheat death is such a manner many would kill for. But %name% does not care. There is only hunger.";

	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...}";
		}
		else
		{
			return "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				15
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				-4,
				0
			],
			RangedSkill = [
				-15,
				0
			],
			MeleeDefense = [
				-5,
				2
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-10,
				0
			]
		};
		return c;
	}

	function onAdded() //bite, exceptions to some injuries and zombie trait
	{
		if (this.m.IsNew)
		{
			this.m.Container.add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
		}

		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite);

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = [ //all injuries associated with stamina regen, health or resolve
		//perma injuries must be managed in actor.nut, NOT here!
		//	"injury.traumatized",
		//	"injury.brain_damage",
		//	"injury.missing_nose",
		//	"injury.weakened_heart",
		//	"injury.collapsed_lung_part",
		//temp
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.broken_ribs",
			"injury.crushed_windpipe",
			"injury.fractured_ribs",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on zombies to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 7);

		if (r == 0)
		{
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 1)
		{
		items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
		items.equip(this.new(""));
		}
		else if (r == 3)
		{
		items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 4)
		{
		items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 5)
		{
		items.equip(this.new("scripts/items/shields/worn_heater_shield"));
		}
		else if (r == 6)
		{
		items.equip(this.new("scripts/items/shields/worn_kite_shield"));
		}
		else if (r == 7)
		{
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([ //1 = least likely
		//	[1, "decayed_coat_of_plates"],
		//	[1, "southern_knight_armor"],
			[1, "decayed_coat_of_scales"],
			[1, "dark_southern_armor_00"],
			[2, ""],
			[2, "decayed_reinforced_mail_hauberk"],
			[2, "cultist_leather_robe"],
			[3, "basic_mail_shirt"],
			[3, "gambeson"],
			[4, "apron"],
			[4, "butcher_apron"],
			[4, "leather_tunic"],
			[5, "leather_wraps"],
			[5, "linen_tunic", this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
		//	[1, "decayed_great_helm"],
			[1, "decayed_closed_flat_top_with_mail"],
			[1, "decayed_closed_flat_top_with_sack"],
		//	[1, "decayed_full_helm"],
		//	[2, "legend_noble_southern_hat"],
			[2, "full_aketon_cap"],
			[2, "kettle_hat"],
		//	[2, "dark_southern_helmet_00"],
			[3, "open_leather_cap"],
			[3, "full_leather_cap"],
			[4, ""]
		]));
	}
});

