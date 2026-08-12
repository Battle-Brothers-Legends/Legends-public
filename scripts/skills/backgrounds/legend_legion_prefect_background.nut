this.legend_legion_prefect_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendLegionPrefect);
		this.m.Name = "Prefect";
		this.m.Icon = "ui/backgrounds/background_legion_prefect.png"; 
		this.m.BackgroundDescription = "An official or administrator with some standing to someone who\'s name and title is unknown to you.";
		this.m.GoodEnding = ""; //to do
		this.m.BadEnding = ""; //to do
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			//this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery,
			this.Const.Attributes.Fatigue
		];
		// this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(1, 3);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
		this.m.Names = _gender ? ::Const.Strings.AncientDeadNamesFemale : ::Const.Strings.AncientDeadNames;
	}

	function onBuildDescription()
	{
		return "{Having completed their academic training quicker than their peers, %name% was fingered for a role in the Legion as one of its administrative clerks. Though the task is daunting, they eagerly accepted to serve the Empire on the battlefield of ink and paper. | Having served on various campaigns in the past, %name% was eager to rise from their grave to conduct the administrative duties of the resurgent Legion. Tome in hand, they swear their new life to the Emperor once more. | Few %people_name% truly excel at the art of shifting numbers. %name% handily stands out as unmatched in their discipline, taking their smarts from the imperial academy and applying it to a real cause. | The third child of a major royal house, %name% had earned their laurels serving in the Legion's administrative divisions centuries past, and rises once more to ensure none forget their name.} {Through a talented regime of both carrot and stick, this prefect understands the importance of motivation amongst the troops. %They_name% keep a bony finger on the pulse of the Legion, quelling dissent before it festers. | Others fight with sword and axe. This prefect favours the quill and inkwell. When poor coordination, logistics, morale, and vision pose a lethal threat to the Legion, this champion of ink rises to strike them down. | Managing numbers, collating reports, amassing intel, and possessing the disparate limbs of the Legion into one united amalgam, this prefect is a master of coordination and clerical planning. | Some prefects content themselves to a life strapped to a desk. This prefect however thrives right behind the battle lines, allocating tactical support and skilfully manoeuvering the Legion\'s many martial assets. | Although the Legion doesn't march on its stomach like in ages past, this prefect ensures that the men remain content, efficient, and honed to fight at a moments notice. Although often unseen, their work oils the ever-turning wheels of the Legion's war machine.} {%name% seemingly delights in their undeath. Whilst the peons waste time to eat and sleep, the lack of bodily upkeep allows this erudite scribe to endlessly log and detail the Legion's activities and many triumphs. | There is much to do, and %name% is rarely seen outside of the officer's tent, endlessly slaving away to maintain the Legion and its warriors. When others do see them, it's often with a look of scholarly smugness, and a fresh ream of paper under-arm. | In the rare moments of quiet, %name% appears to panic upon the fresh realisation of their undeath. Only through constant occupation of their fierce and brilliant mind can they quiet the horrors that surround them. | %name% isn't afraid to debase their station through eager interaction with their subordinates. While unorthodox, their methods allow enhanced observation of the Legion's morale and attitudes — a scroll rarely leaving their hand. | The scholarly and inquisitive %name% took quite nicely to their new form, eager to explore its implications and potential. When not balancing Legion books, they can be seen furiously scribbling in their own private tomes.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLegionPrefect);
	}

	function onAdded()
	{
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command");  //justifies if this background is subject to the legion command skill
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
			[1, "weapons/ancient/bladed_pike"],
			[1, "weapons/ancient/legend_gladius"],
			[1, "weapons/ancient/legend_kopis"],
			[1, "weapons/ancient/warscythe"]
		], "scripts/items/"));

		items.equip(::Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[2, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None]
		]));
	}
});
