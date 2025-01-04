::mods_hookExactClass("skills/perks/perk_steadfast", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.FatigueReceivedPerHitMult *= 0.1;
		_properties.FatigueLossOnBeingMissedMult *= 0.1;
	}
});
