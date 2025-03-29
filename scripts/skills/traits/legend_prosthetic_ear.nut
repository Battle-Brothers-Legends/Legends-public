this.legend_prosthetic_ear <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticEar);
		this.m.Name = "Prosthetic Ear";
		this.m.Icon = "ui/traits/legend_prosthetic_ear.png";
		this.m.Description = "A wax ear stitched into one\'s head. Hardly a proper replacement, but some sense of balance is returned and very faint noises can be heard.";
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Initiative"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 0.95;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_2");
		sprite.setBrush("permanent_injury_02");
		sprite.Visible = false;
	}

});
