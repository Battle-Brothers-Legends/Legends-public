::mods_hookExactClass("skills/perks/perk_devastating_strikes", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.DamageTotalMult *= 1.1;
	}
});
