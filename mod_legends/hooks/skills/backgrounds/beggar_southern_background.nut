::mods_hookExactClass("skills/backgrounds/beggar_southern_background", function (o) {
	o.create = function () {
		this.beggar_background.create();
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleSkinny, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.UntidyMale, HairColors =::Const.HairColors.Southern}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernSkinny, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.UntidyMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.SouthernUntidy}, 90);
		if (_gender != 1) return;
		this.m.Name = "Widow";
		this.m.Icon = "ui/backgrounds/background_widow.png";
		this.m.BackgroundDescription = "Widows who can\'t find another husband have few choices, mercenary work is a last resort of the hopeless.";
	}

	o.onBuildDescription <- function () {
		return "{After losing everything to a fire | After %their% gambling addiction got the better of %them% | Framed for a crime %they% didn\'t commit, and having to pay the constable everything to keep %themselves% out of the dungeons | A refugee after %their% village was burned to the ground | Banished from %their% home after a violent struggle with %their% brother | A man with few talents and no ambition | After being released from a dungeon where %they% spent countless years chained to a wall | After giving all %their% worldly possessions to an obscure cult promising salvation of %their% eternal soul | A very intelligent %person% until a nomad knocked %them% over the head}, {%name% found %themselves% on the streets, | %name% was forced onto the streets,} {having to beg for bread | depending on the goodwill of others | being beaten and resigned to %their% fate | spending what little coin %they% had to drink the days away | digging into the trash of others and scurrying away from lawmen | avoiding ruffians and thugs while %they% begged for crowns}. {While %they% seems earnest in becoming a mercenary, there is little doubt that all %their% time on the street have robbed %name% of %their% best years. | Years have passed and took a toll on %their% health by now. | Once a %person% like %name% has spent a few days on the streets, much less a few years, even the very dangerous job of being a sellsword seems like the greenest of pastures. | Only the gods know what %name% has done to survive, but %they% is a frail %person% standing before you now. | At the sight of you %they% rises with open arms to embrace you, claiming to know you well from years past and many a shared adventure, although your name escapes %them% at the moment.}";
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/knife"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap, 16],
			[3, ::Legends.Helmet.None]
		]);
		items.equip(helm);

	}
});
