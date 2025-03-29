this.legend_prosthetic_nose <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticNose);
		this.m.Name = "Prosthetic Nose";
		this.m.Icon = "ui/traits/legend_prosthetic_nose.png";
		this.m.Description = "A roughly made fake nose that does more to ensure the wearer can actually breath than actually make them look nice. Try not to lie.";
	}

	function getTooltip()
	{
		local ret = [
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Max Fatigue"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.StaminaMult *= 0.95;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_3");
		sprite.setBrush("permanent_injury_03");
		sprite.Visible = false;
	}

});
