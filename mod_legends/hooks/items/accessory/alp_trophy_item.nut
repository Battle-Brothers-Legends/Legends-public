::mods_hookExactClass("items/accessory/alp_trophy_item", function(o) {
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
				id = 66,
				type = "text",
				text = this.getValueString()
			},
			{
				id = 3,
				type = "image",
				image = this.getIconLarge() != null ? this.getIconLarge() : this.getIcon(),
				isLarge = this.getIconLarge() != null
			},
			{
				id = 67,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]5%[/color] Experience Gain"
			},
			{
				id = 69,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Mitigates [color=%positive%]25%[/color] of night penalties."
			}
		];
	}

	o.onUpdateProperties = function ( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.XPGainMult *= 1.05;
	}

	o.onAfterUpdateProperties <- function ( _properties )
	{
		this.accessory.onAfterUpdateProperties(_properties);

		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return;

		if (_properties.IsAffectedByNight && ::Legends.Effects.has(this.getContainer().getActor(), ::Legends.Effect.Night)) {
			_properties.RangedSkillMult *= 1.107;
			_properties.RangedDefense *= 1.107;
		}
	}
});
