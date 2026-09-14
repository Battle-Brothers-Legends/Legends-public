::mods_hookExactClass("skills/perks/perk_relentless", function(o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		onUpdate(_properties);
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
	}
});