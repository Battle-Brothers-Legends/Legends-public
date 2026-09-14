this.legend_steady_hands_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendSteadyHands);
		this.m.Name = "Steady Hands";
		this.m.Icon = "ui/traits/legend_steady_hands.png";
		this.m.Description = "Having particularly steady hands, this character can shoot straighter than most";
		this.m.Titles = [
			"the Steady",
			"the Still",
			"the Quiet",
			"the Calm",
			"the Cold",
			"the Hawk"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Impatient)
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
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+5[/color] Ranged Skill"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkill += 5;
	}

});

