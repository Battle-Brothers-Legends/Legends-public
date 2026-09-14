::mods_hookExactClass("skills/traits/eagle_eyes_trait", function(o)
{
	o.m.Vision <- 2;
	o.getTooltip = function ()
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
				text = "[color=%positive%]+" + this.m.Vision + "[/color] Vision"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.Vision += 2;
	}
});
