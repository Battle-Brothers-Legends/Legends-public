this.legend_prosthetic_foot <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticFoot);
		this.m.Name = "Prosthetic Foot";
		this.m.Icon = "ui/traits/legend_prosthetic_foot.png";
		this.m.Description = "Amputation is a thing of life, and the wearer of this prosthetic foot was lucky enough to be given a replacement after the removal of their maimed one. It\'s awful to walk on, but at least you can walk.";
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
				icon = "ui/icons/special.png",
				text = "Builds up [color=" + this.Const.UI.Color.NegativeValue + "]3[/color] more fatigue for each tile travelled"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Initiative"
			}
		];
	}

	function onUpdate (_properties)
	{
		_properties.MovementFatigueCostAdditional += 3;
		_properties.InitiativeMult *= 0.9;
	}
});
