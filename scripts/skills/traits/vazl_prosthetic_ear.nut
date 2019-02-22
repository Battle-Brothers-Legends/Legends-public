this.vazl_prosthetic_ear <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.vazl_prosthetic_ear";
		this.m.Name = "Prosthetic Ear";
		this.m.Icon = "ui/traits/vazl_prosthetic_ear.png";
		this.m.Description = "Ear.";
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
		this.addTooltipHint(ret);
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
