this.legend_natural_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendNatural);
		this.m.Name = "Talented";
		this.m.Icon = "ui/traits/natural_trait.png";
		this.m.Description = "Has natural skills, talents and abilities. Born to be successful.";
		this.m.Titles = [
			"the Talented",
			"the Smart",
			"the Natural",
			"the Gifted"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail)
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Hitpoints"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Fatigue"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Experience Gain"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 1.05;
		_properties.Hitpoints += 3;
		_properties.Stamina += 3;
	}

});

