::mods_hookExactClass("skills/backgrounds/slave_barbarian_background", function (o) {
	o.create = function ()
	{
		this.slave_background.create();
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Bodies = this.Const.Bodies.AllMale;
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
			this.Const.Attributes.Bravery
		];
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.SlaveBarbarian);
	}
});

