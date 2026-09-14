::mods_hookExactClass("skills/traits/oath_of_distinction_trait", function(o)
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().isPlacedOnMap())
			return onUpdate(_properties);
	}
});
