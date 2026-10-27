this.legend_muladi_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create() {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendMuladi);
		this.m.Name = "Muladí";
		this.m.BackgroundDescription = "A muladi is accustomed to the south, although not entirely accepted by the locals.";
		this.m.GoodEnding = "Ever an outcast, %name% returned home and used the crowns gained from %their% adventures to buy a home far away from those who scorned %them% in the past. The link between nature and %name% strengthened, acting a safe haven for those wronged or on the run.";
		this.m.BadEnding = "Living on the divide was a dangerous business, in attempting to return home %they% were driven out by northern militia on a border town with the desert. Alone, hungry and desperate. %name% was easy prey for the wild animals %they% once called kin.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts)
		];
		this.m.BackgroundType = ::Const.BackgroundType.Lowborn | ::Const.BackgroundType.Ranger | ::Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Notorious;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		this.setBodyCharacteristics(_gender, _gender ? {
			Bodies = ::Const.Bodies.FemaleSkinny,
			Faces = ::Const.Faces.PrettyFemale,
			HairColors = ::Const.HairColors.Young
		} : {
			Bodies = ::Const.Bodies.Skinny,
			Hairs = ::Const.Hair.UntidyMale,
			Beards = ::Const.Beards.Untidy
		});
	}

	function onBuildDescription() {
		return "{Despite the clothing and language of the south, %name% has always been regarded with contempt by %their% fellow southerners who prefer to name them \'outsider\' than anything else. | Life on the edge of society taught %name% about a lot of things - self reliance, animal kinship, and how to effectively fell a man at 30 paces with an arrow. } {Once a northerner, %name% dresses, speaks and acts in all southern customs. Much to the irritation of some of the local inhabitants. | %name%'s presence is seen as a threat by some and an abomination by others. | %name% assures you that this way of life is not as painful as it may seem, despite the occasional insults from the locals. } {%name% stands out to everyone around them - at a glance %they% appears to be your typical nomad wandering the streets or moving across the dunes, but on closer inspection many will recognise %their% face has not been gilded by the sun and is missing the darker hair common in this region.  | %name% is a self appointed outcast, or perhaps a victim of shifting territories and warring cultures. } {%name%'s existence is quite simple - life at the rim of society allows %them% to appreciate the more natural things in life. Nature, landscapes and the occasional holy war far off on the horizon. | The aggression and violence of humanity is what led %name% to adopt more of the southern customs, perhaps feeling that trading multiple tyrants for a singular one would be a favourable transaction. | %name% remarks %they% moved only for the food, but you suspect %they% came for a little bit more than that.}";
	}

	function onAdded() {
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Muladi");
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendMuladi);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[5, "weapons/short_bow"],
			[3, "weapons/legend_dilapidated_sling"],
			[2, "weapons/wonky_bow"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickBasicAmmo(items.getItemAtSlot(::Const.ItemSlot.Mainhand)));

		items.addToBag(::Legends.Items.pickItem([
			[1, "weapons/knife"],
			[1, "weapons/militia_spear"],
			[3, null]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickItem([
			[1, "accessory/legend_wardog_item"],
			[1, "accessory/legend_sighthound_item"],
		], "scripts/items/"));

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));

		local helm = ::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap]
		]);
		items.equip(helm);
	}
});
