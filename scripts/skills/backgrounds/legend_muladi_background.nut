this.legend_muladi_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.LegendMuladi);
		this.m.Name = "Muladí";
		this.m.Icon = "ui/backgrounds/background_muladi.png";
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
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.BowTree,
				::Const.Perks.SlingTree,
				::Const.Perks.DaggerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.CalmTree,
				::Const.Perks.FastTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.AgileTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree
			],
			Class = [
				::Const.Perks.HoundmasterClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny, Faces = ::Const.Faces.PrettyFemale, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	function onBuildDescription() {
		return "{Despite the clothing and language of the south, %name% has always been regarded with contempt by %their% fellow southerners who prefer to name them \'outsider\' than anything else. | Life on the edge of society taught %name% about a lot of things - self reliance, animal kinship, and how to effectively fell a man at 30 paces with an arrow. } {Once a northerner, %name% dresses, speaks and acts in all southern customs. Much to the irritation of some of the local inhabitants. | %name%'s presence is seen as a threat by some and an abomination by others. | %name% assures you that this way of life is not as painful as it may seem, despite the occasional insults from the locals. } {%name% stands out to everyone around them - at a glance %they% appears to be your typical nomad wandering the streets or moving across the dunes, but on closer inspection many will recognise %their% face has not been gilded by the sun and is missing the darker hair common in this region.  | %name% is a self appointed outcast, or perhaps a victim of shifting territories and warring cultures. } {%name%'s existence is quite simple - life at the rim of society allows %them% to appreciate the more natural things in life. Nature, landscapes and the occasional holy war far off on the horizon. | The aggression and violence of humanity is what led %name% to adopt more of the southern customs, perhaps feeling that trading multiple tyrants for a singular one would be a favourable transaction. | %name% remarks %they% moved only for the food, but you suspect %they% came for a little bit more than that.}"
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Muladi");
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendMuladi);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Wildmen)
		{
			r = this.Math.rand(1, 100);

			if (r <= 50)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r <= 80)
			{
				items.equip(this.new("scripts/items/weapons/legend_dilapidated_sling"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
		}
		else
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
			}

			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}

		items.equip(this.new("scripts/items/accessory/legend_wardog_item"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap]
		]);
		items.equip(helm);
	}
});
