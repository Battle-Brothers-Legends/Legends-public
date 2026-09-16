::mods_hookExactClass("skills/backgrounds/slave_barbarian_background", function (o) {
	o.create = function ()
	{
		this.slave_background.create();
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.WildExtended;
		this.m.Bodies = ::Const.Bodies.AllMale;
		this.m.Ethnicity = 0;
		this.m.Titles = [
			"the Barbarian",
			"the Northman",
			"the Pale",
			"the Prisoner",
			"the Unlucky",
			"the Enslaved",
			"the Raider",
			"the Captive",
			"the Unfree",
			"the Unruly",
			"the Restrained",
			"the Shackled",
			"the Bound"
		];
		this.m.ExcludedTalents = [
			::Const.Attributes.Bravery
		];
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.SlaveBarbarian);
	}
});

