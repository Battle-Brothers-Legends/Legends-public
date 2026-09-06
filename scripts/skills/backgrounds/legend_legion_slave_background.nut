this.legend_legion_slave_background <- this.inherit("scripts/skills/backgrounds/legend_legion_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendLegionSlave);
		this.m.BackgroundDescription = "Taken from a distant land lost to time, this slave still fights for their master.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		];
		// this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		// this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
		this.m.Names = _gender ? ::Const.Strings.AncientDeadNamesFemale : ::Const.Strings.AncientDeadNames;
	}

	function onBuildDescription() //—
	{
		return "{%name% hunches and hobbles along as though %their% bone frame was still burdened by calloused flesh and aching muscles. | %name% appears oblivious to %their% undeath, limping and lamenting %their% station, ever fearful of %their% superiors overhearing and adding to %their% misfortunes. | Wearing the scars of decades of servitude at the bottom of the Legion, %name%\'s bony frame threatens to crumble under the weight of more orders. | March. Dig. Cook. Build. March. Kill. March. The endless labours of %name% persist even in the face of %their% undeath. | With a bony frame that portrays weakness and years of backbreaking work even after death, %name% shuffles with a stiffness that betrays %their% battered state.} {A slave in the Legion, %their% station affords %them% an excessive regime of endless work. Digging trenches, stripping corpses, and making said corpses dominate the daily unlife of this walking cadaver. | Filling the disposable ranks of the Legion\'s many slaves, %their% work is dominated with manual and violent tasks to ensure the unimpeded task of the machine-like Legion. | As one of many faceless slaves within the Legion, %they% fills the role of the disposable body to throw at problems — fighting, carrying of supplies, and %their% eventual destruction are vital parts of %their% role. | Providing comforts to the rest of the Legion at the expense of %their% own, the work of a Legion slave is one of never-ending toil and torment. | The often unseen labour behind the Legion\'s frightening efficiency, the labouring slave shares no glory and wins no accolades for its success, but is first to suffer setbacks both on and off the battlefield.} {If %name%'s face had any flesh or human features left, it would betray unspeakable sadness and desperation in the face of %their% endless torment. Instead, a cold and hollow skull hides such inconveniences, only presenting as ready for more orders. | Despite their station, %name% wears a misplaced enthusiasm to serve and better %their% situation, tricked by %their% own delusion that eventually, %their% toils will end, and %they% will rise through the Legion as a respected figure. | Fearing the ever-present judgement of their betters, %name% toils with a fervour that threatens to break apart %their% fragile frame. | The resignation to %their% fate is clear in how %name% carries %themselves%. Aware of %their% nature within the Legion\'s endless campaign, %they% seemingly awaits %their% destruction to return %them% to the earth, were %they% so lucky. | Having spent little time in %their% station, the almost eager demeanour of %name% is likely to be short lived. With the weight of the Legion\'s endless orders upon %their% hollow shoulders, one must wonder how long they\'ll last before crumbling into dust...}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLegionSlave);
	}

	function onAdded()
	{
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command");  //justifies if this background is subject to the Legion command skill
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
			[1, "weapons/ancient/broken_ancient_sword"],
			[1, "weapons/ancient/falx"],
			[1, "weapons/ancient/ancient_spear"],
			[1, "weapons/legend_dilapidated_sling"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			if (this.Math.rand(1, 100) <= 66)
				items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Standard.leather_wraps],
			[3, ::Legends.Armor.Standard.indebted_armor_rags],
			[2, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[3, ::Legends.Armor.None]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_household_helmet],
			[2, ::Legends.Helmet.None]
		]));
	}
});
