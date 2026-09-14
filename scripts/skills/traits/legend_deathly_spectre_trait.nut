this.legend_deathly_spectre_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendDeathlySpectre);
		this.m.Name = "Deathly spectre";
		this.m.Icon = "ui/perks/raisedead2_circle.png";
		this.m.Description = "The shadow of undeath follows this character due to having a necromancer nearby, they will probably be resurrected after death but retain any injuries sustained.";
		this.m.Titles = [
			"the Doomed",
			"the Forsaken",
			"the Dying"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Ailing)
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
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]66%[/color] chance to be resurrected as undead when killed, any injuries will be retained"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.SurviveWithInjuryChanceMult *= 2.72;
		_properties.SurvivesAsUndead = true;
	}

});

