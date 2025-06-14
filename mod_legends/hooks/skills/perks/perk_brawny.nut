::mods_hookExactClass("skills/perks/perk_brawny", function(o) {
	o.onUpdate <- function ( _properties )
	{
		local fat = this.getContainer().getActor().getFatigueMax() * 0.1 ;
		_properties.FatigueEffectMult *= 1.00 - 0.01 * fat;
	}
});