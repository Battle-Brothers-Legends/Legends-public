this.legend_inquisition_disciple_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendInquisitionDisciple);
		this.m.Name = "Disciple of the Inquisition";
		this.m.Icon = "ui/traits/trait_icon_67.png";
		this.m.Description = "This character is a disciple of the Old Gods, an individual with unquestionable loyalty to the faith. They embrace physical pain and peril as bringing them closer to salvation.";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
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
				text = "[color=%positive%]+20[/color] Hitpoints"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+10[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is not affected by fresh injuries sustained during the current battle"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 20;
		_properties.Bravery += 10;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

