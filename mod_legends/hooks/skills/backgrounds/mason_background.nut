::mods_hookExactClass("skills/backgrounds/mason_background", function (o) {
	o.create = function () {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Mason);
		this.m.BackgroundDescription = "A good mason is used to physical labor and studying to improve %their% craft.";
		this.m.GoodEnding = "Masonry has its own call, notably a call for perfectly cut stones and impossible towers that defy the eye\'s ability to even shape them against the skies. %name% the mason returned to %their% old trade and, with all the money %they%\'d made with the %companyname%, %they% started a reputable business renowned for its ability to construct stone rooms that held the heat during winters and the cool during summers.";
		this.m.BadEnding = "The %companyname% continued to suffer losses long after you\'d left. More and more of the brothers departed the company, a good lot of them returning to old trades. %name% the mason was no different. Sadly, all the time spent fighting had destroyed any steadiness %they% had left. With hands that wouldn\'t stop shaking, %they% could no longer shape stones like %they% used to. Last you heard, %they% was hauling rocks as a daytaler instead of shaping them as a mason.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.BackgroundType = this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
	}

	o.getTooltip = function () {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=%positive%]+5%[/color] Experience Gain"
		});
		return ret;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale});
	}

	o.onBuildDescription <- function () {
		return "{Growing up in %townname%, %name% spent %their% youth poring over construction books with earnest. | Raised by a guild of tradesmen, %name%\'s swift ascent through the field of masonry was of little surprise. | A student of %randomtown%\'s esteemed college, %name% graduated with great expectations, and even greater things yet to build. | With a bricklayer for a father, %name%\'s entrance into masonry was but the smallest of steps. | Amazed by the regal structures of church and state, %name% fell in love with masonry. | When %randomtown% was in dire need of defensive walls, %name% took to masonry like a very fortunately-timed natural.} {Unfortunately, %their% time as a mason was short-lived. A church %they% built collapsed and out of its ruins rose a murderous mob looking for revenge. | Five buildings built, five buildings knocked down. Endless wars made the %person%\'s vocation an impossible one. | Betrayed by a fellow architect, the mason bricked %their% rival inside the walls of %their% next project. It wasn\'t long until people started asking questions. | While roofing, the %person% took a misstep and fell. The ensuing injuries forced %them% out of %their% field. | But when a lord demanded %they% build a horrific dungeon, the mason refused. Now %they% is banished from ever laying a brick again. | A misplaced blueprint had the mason building the temple of the Davkulians and not the temple of the Davkuliads. Now %they% says the gods themselves are after %them%.} {Putting down %their% hammer and chisel for a hammer and a sharpened chisel called a sword, %name% now works in the field of mercenaries. | One day, a poster for a mercenary troop caught %their% eye. Much like %their% old buildings, the rest is history. | Years of masonry made the %person% fit for a life of blood and mud. | %name% finds a flaw in every building %they% passes. Hopefully %they% can tune that annoying analysis to the battlefield.}";
	}

	o.onChangeAttributes = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.Mason);
	}

	o.onAdded = function () {
		this.character_background.onAdded();

		if (::Math.rand(0, 3) == 3) {
			this.getContainer().getActor().setTitle(this.Const.Strings.MasonTitles[this.Math.rand(0, this.Const.Strings.MasonTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function () {
		this.getContainer().getActor().getItems().equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));
	}

	o.onUpdate = function (_properties) {
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.05;
	}
});
