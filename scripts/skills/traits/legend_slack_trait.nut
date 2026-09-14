this.legend_slack_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendSlack);
		this.m.Name = "Slack";
		this.m.Icon = "ui/traits/slack_trait.png";
		this.m.Description = "Doesn\'t really care what you are doing. Just here for salary and food.";
		this.m.Titles = [
			"the Slack",
			"the Lazy"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
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
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-3[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-3[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]-5%[/color] Experience Gain"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
		_properties.XPGainMult *= 0.95;
		_properties.Bravery -= 3;
		_properties.Initiative -= 3;
	}

});

