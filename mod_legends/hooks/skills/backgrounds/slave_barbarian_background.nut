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
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.SouthernersTree,
				this.Const.Perks.NoblesTree
			],
			Class = [],
			Profession = [], 
			Magic = []
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				4,
				9
			],
			Bravery = [
				0,
				2
			],
			Stamina = [
				8,
				14
			],
			MeleeSkill = [
				4,
				8
			],
			RangedSkill = [
				3,
				5
			],
			MeleeDefense = [
				0,
				1
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-8,
				-5
			]
		};
		return c;
	}

	//no need to do legendsequipment here because it inherits from slave_background

});

