::mods_hookExactClass("skills/backgrounds/monk_turned_flagellant_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.MonkTurnedFlagellant);
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
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
	}

	o.onBuildDescription <- function ()
	{
		return "The world was too dark for %name% to continue his ways. A talk with a flagellant showed him that the old gods are not happy with man\'s pursuits of justice through reasonable means. Now the once-monk can be found whipping himself, bleeding righteousness into the world one strike at a time.";
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();

			if (actor.getTitle() == "")
			{
				actor.setTitle(this.Const.Strings.PilgrimTitles[this.Math.rand(0, this.Const.Strings.PilgrimTitles.len() - 1)]);
			}
		}
	}

	o.onAddEquipment = function ()
	{
	}
});
