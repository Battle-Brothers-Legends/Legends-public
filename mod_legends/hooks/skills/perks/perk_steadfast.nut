::mods_hookExactClass("skills/perks/perk_steadfast", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.FatigueLossOnAnyAttackMult *= 0.1;
	}
});
