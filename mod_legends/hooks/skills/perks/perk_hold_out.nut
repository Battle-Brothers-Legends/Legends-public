::mods_hookExactClass("skills/perks/perk_hold_out", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.NegativeStatusEffectDuration += -10;
		_properties.Hitpoints += 8;
		_properties.SurviveWithInjuryChanceMult = 2.00; // 2 x 33 = 66% chance to get up after being struck down.
	}
});