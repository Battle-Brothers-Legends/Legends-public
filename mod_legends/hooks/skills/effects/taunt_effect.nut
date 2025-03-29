::mods_hookExactClass("skills/effects/taunt_effect", function(o) {
	
	o.onUpdate = function ( _properties )
	{
		_properties.TargetAttractionMult *= 1.2;
	}
});