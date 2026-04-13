::mods_hookExactClass("skills/backgrounds/pacified_flagellant_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.pacified_flagellant";
		this.m.Name = "Pacified Flagellant";
		this.m.Icon = "ui/backgrounds/background_13.png";
		this.m.HiringCost = 60;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
				this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.FlailTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.SlingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.MartyrTree,
				::Const.Perks.IndestructibleTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.NinetailsClassTree,
				::Const.Perks.FaithClassTree
				],
			Profession = [
				::Const.Perks.HealerProfessionTree,
			],
			Magic = []
		}
	}

	o.onBuildDescription <- function ()
	{
		return "After a long talk with a monk, %name% was converted to a more peaceful means of expressing his faith. Now when he picks up a weapon you can be assured it will only be pointed at someone other than himself.";
	}

	o.onAddEquipment = function ()
	{
	}
});
