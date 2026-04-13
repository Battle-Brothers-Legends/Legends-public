::mods_hookExactClass("items/accessory/legendary/cursed_crystal_skull", function(o) {
	local onUpdateProperties = o.onUpdateProperties;
	o.onUpdateProperties = function ( _properties )
	{	
		local actor = this.getContainer().getActor();
		if (actor.m.MoraleState == ::Const.MoraleState.Ignore)
			_properties.Threat += 10;
		else
			onUpdateProperties(_properties);
	}
});
