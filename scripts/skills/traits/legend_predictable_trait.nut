this.legend_predictable_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendPredictable);
		this.m.Name = "Predictable";
		this.m.Icon = "ui/traits/predictable_trait.png";
		this.m.Description = "It is always quite clear what this character is about to do, announcing hits before they come and looking intently for a moment before deciding to move. This gives time for enemies to dodge away.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable)
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
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-5[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%negative%]-10%[/color] Chance To Hit Head"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] -= 10;
		_properties.Initiative -= 5;
	}

});

