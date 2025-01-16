this.legend_arena_veteran_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendArenaVeteran);
		this.m.Name = "Arena Veteran";
		this.m.Icon = "ui/traits/trait_icon_75.png";
		this.m.Description = "A veteran of the arena with many a scar, this character knows how to make the crowd cheer for a bloody spectacle. The worse the odds of winning, the better the entertainment!";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		local matches = this.getContainer().getActor().getFlags().getAsInt("ArenaFights");
		local won = this.getContainer().getActor().getFlags().getAsInt("ArenaFightsWon");

		if (won == matches)
		{
			won = "all";
		}

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() + " So far, this character has fought in " + matches + " matches and won " + won + " of them."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance to survive if struck down and not killed by a fatality"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 10;
		_properties.SurviveWithInjuryChanceMult *= 1.51;
	}

});

