::mods_hookExactClass("skills/backgrounds/belly_dancer_background", function(o) {
	o.create = function () {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.BellyDancer);
		this.m.Icon = "ui/backgrounds/background_64.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the southern belly dancer left the company in good time. While %their%... particularities made %them% an excellent soldier, it was not %them% life\'s passion. To entertain, through rhythmic, confusingly erotic motions, that is what %they% wanted. The last you heard, they were in the court of a Vizier serving not only as an entertainer, but, thanks to time with the %companyname%, also as an adviser on martial matters.";
		this.m.BadEnding = "As the company failed to achieve the success you had hoped for, many departed its ranks. The southern belly dancer joined them. Unfortunately, %name% sought to ply %them% trade in the north, thinking %they% might be able to spread culture there. The indigenous population was quick to accuse %them% of \'unregulated body sorcery\' and burn %name% at the stake.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable),
			::Legends.Traits.getID(::Legends.Trait.Dumb)
		];
		// this.m.ExcludedTalents = [
		// 	this.Const.Attributes.Hitpoints,
		// 	this.Const.Attributes.Fatigue,
		// 	this.Const.Attributes.Bravery
		// ];
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing;
	}

	function onBuildDescription() {
		return "%name% caught your eye during a festival held on a street corner, her singing voice was the most serene thing you had ever heard, {yet the chains of slavemasters rattled and clattered, masking her falsettos. | yet her owners keep her at a distance, despite her delicate demeanour.} After verifying her claims that she stabbed a man twice her size to death in the street only a few weeks ago, you may think that she has what it takes to work in more gainful employment. %name% talks at length about her routine as a slave girl. { She always wore as little clothing as she could get away with and her dances enthralled men and women alike | She would dance for hours in public or private, normally for the wealthiest men in the land } and then she killed them with mundane objects like incense sticks, candles and even her own clothes. This would explain why %name% wears broken shackles and is currently on the run from her employers. {%name% used to be a slave girl, she is very particular on using the past tense when describing her past involving \'the rice and that stupid noble boy\'. | When asked why she dances, she laughs and motions to the flowers and herbs adorning her hair. While you are no expert, you do recognise at least two types that could kill a donkey in just a few bites. } {She is a mysterious character, under whose clothing you can hear the occasional rattle of chains and the flash of a knife. | While having all the hallmarks of a slave and an assassin, she prefers to recite political treatise and poetry, almost word for word, to anyone who will listen. | Either a political captive or perhaps a recently learned woman, she can sit down with anyone and explain how to effectively, silently and efficiently kill any man with nothing but a scrap of metal and the element of surprise. Almost word for word.}";
	}

	o.getTooltip = function () {
		local ret = this.character_background.getTooltip();
		ret.push( {
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "[color=%positive%]+10%[/color] Chance To Hit Head"
		});
		return ret;
	}

	o.onChangeAttributes = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.BellyDancer);
	}

	o.onUpdate <- function ( _properties ) {
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

	o.onAdded <- function () {
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Belly Dancer");
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash]
		]);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Southern.legend_headband_coin],
			[1, ::Legends.Helmet.Southern.legend_headress_coin],
			[1, ::Legends.Helmet.Southern.legend_earings],
			[5, ::Legends.Helmet.Southern.legend_southern_veil],
			[1, ::Legends.Helmet.Southern.legend_southern_cloth_headress]
		]));
	}
});
