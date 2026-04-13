::mods_hookExactClass("skills/effects_world/new_trained_effect", function(o)
{	
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().isPlacedOnMap())
			return onUpdate(_properties);
	}
});
