this.legend_legion_honour_guard_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendLegionHonourGuard); //I don't care who they send, im not spelling it 'honor'.
		this.m.Name = "Honour Guard";
		this.m.Icon = "ui/backgrounds/background_legion_honourguard.png";
		this.m.BackgroundDescription = "A veteran of hundreds of battles, the honour guard is rewarded for their luck and prowess with ever increasing danger.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			// this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		];

		// this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
		this.m.Names = _gender ? ::Const.Strings.AncientDeadNamesFemale : ::Const.Strings.AncientDeadNames;
	}

	function onBuildDescription() {
		return "{Decades of campaigning and violence have only cemented %name%'s reputation in the Legion as an avatar of war. Their very presence instils confidence in their troop's fighting odds. | Some %name% are born to grant others death. %name% answered this calling alongside his duty to the Emperor, and has carved a path through their many enemies, with little sign of stopping. | %name%'s war never ended. Found amongst a battlefield surrounded by felled foes, they were only too eager to take up arms again in service of the Emperor and his Legion. | %name% sought the Legion out on their own, having felt the call to serve the Emperor through honourable combat. Offered a prestigious position as one of the Legion's best, they stand as both shield and sword against the Empire's many enemies. | Few can compare to %name%'s martial prowess and imposing presence, even in death. Quickly proving their knack for violence, they secured a place in the Legion's honour guard.} {When the lines break, it inevitably falls to this honour guard to hold the line and salvage the day. Unmatched in close combat, they can be trusted to make any enemy pay in rivers of blood. | Perfectly suited to breaking enemy lines and reforming allied ones, this honour guard stands stalwart as a decisive actor on the battlefield. Enemies and allies alike fear their skill of arms. | When the day seems lost, it falls to an honour guard to turn the tide and achieve glory for the Empire. Masterfully applied violence and a feverish loyalty to the mission bolster the Legion's capabilities on and off the battlefield. | The perfect weapon in the Legion, this honour guard is the solution to throw at almost any problem that stands against the Emperor's will. Single-minded in violence, the Empire's enemies tremble at the very sight of this paragon of imperial martial excellence. | Violence made art. Killing made a science. This honour guard is no stranger to war, and can be relied upon to demonstrate the ancient mastery of imperial war to those in the Legion, and those who dare oppose it.} {Cold, reserved and unmistakably absent-minded in camp, %name%'s mind clearly lives on the battlefield. The lulls between battle seem only to send this agent of war into a placated stasis, awaiting the next call to action... | Death comes easy for some. %name% appears aware of their undeath, occasionally spotted admiring their skeletal form. Despite what some might consider horrific, they relish the opportunity to relive the art of killing. Again, and again, and again. | %name% relishes their new undead station in the Legion, eagerly flexing their status against their inferiors, and often failing to hide their glee for their curse of unlife. At least someone is having fun in death. | Bouts of confused stupors quickly give way to an unquestionable discipline practised and perfected over countless years. Though %name% is sometimes spotted pensive and disturbed by their undead company, the order to form ranks quickly sweeps such self-awareness away... | %name% lived and died and now lives again for the Legion. Eagerly taking up the opportunity to serve the Emperor once more, they vow never to never again fall in battle.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLegionHonourGuard);
	}

	function onAdded()
	{
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command"); //justifies if this background is subject to the legion command skill
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
			[1, "weapons/ancient/warscythe"],
			[1, "weapons/ancient/rhomphaia"],
			[1, "weapons/ancient/ancient_sword"],
			[1, "weapons/ancient/crypt_cleaver"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			items.equip(::Const.World.Common.pickItem([
				[2, "shields/ancient/coffin_shield"],
				[1, "shields/ancient/tower_shield"]
			], "scripts/items/"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[2, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.None]
		]));
	}
});
