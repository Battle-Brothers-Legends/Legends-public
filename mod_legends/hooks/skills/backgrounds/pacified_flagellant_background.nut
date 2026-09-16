::mods_hookExactClass("skills/backgrounds/pacified_flagellant_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.PacifiedFlagellant);
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
		this.m.Faces = ::Const.Faces.AllWhiteMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Untidy;
		this.m.BackgroundType = ::Const.BackgroundType.OffendedByViolence;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Saintly;
	}

	o.onBuildDescription <- function ()
	{
		return "After a long talk with a monk, %name% was converted to a more peaceful means of expressing his faith. Now when he picks up a weapon you can be assured it will only be pointed at someone other than himself.";
	}

	o.onAddEquipment = function ()
	{
	}
});
