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
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.MaceTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.LargeTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.SlaveBarbarian);
	}

	//no need to do legendsequipment here because it inherits from slave_background

});

