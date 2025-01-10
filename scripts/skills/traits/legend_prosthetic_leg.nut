this.legend_prosthetic_leg <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticLeg);
		this.m.Name = "Prosthetic Leg";
		this.m.Icon = "ui/traits/legend_prosthetic_leg.png";
		this.m.Description = "A fake leg of wood and metal. Not much to run on, but at least it\'ll let a man hobble. While it makes the most annoying clanking noise you\'ve ever heard, it\'ll ensure a mercenary is able to walk.";
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Ranged Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Initiative"
			}
		];
	}

	function onUpdate (_properties)
	{
		_properties.MeleeDefenseMult *= 0.85;
		_properties.RangedDefenseMult *= 0.85;
		_properties.InitiativeMult *= 0.8;
	}
});
