this.legend_diurnal_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_diurnal";
		this.m.Name = "Diurnal";
		this.m.Icon = "skills/diurnal_circle.png";
		this.m.Description = "This character is particularly sensitive to light levels, gaining an additional vision in the day and losing an additional vision at night";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.NightOwl),
			::Legends.Traits.getID(::Legends.Trait.NightBlind)
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
				id = 10,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Vision during daytime"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color] Vision during nighttime"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().hasEffect(::Legends.Effect.Night))
		{
			_properties.Vision += 1;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.Night))
		{
			_properties.Vision -= 1;
		}

	}

});

