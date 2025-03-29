this.legend_appetite_donkey <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendDonkeyAppetite);
		this.m.Name = "Appetite of a donkey";
		this.m.Icon = "ui/traits/legend_appetite_donkey.png";
		this.m.Description = "This character has a huge appetite and will eat anything. Better bring extra provisions when traveling with this character and expect them to leave fast if you ever run out of provisions entirely.";
		this.m.Titles = [
			"the Ass",
			"the Donkey",
			"the Jackass"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Fragile)
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function addTitle()
	{
		this.character_trait.addTitle();
	}

	function onUpdate( _properties )
	{
		_properties.DailyFood += 4.0;
	}

});
