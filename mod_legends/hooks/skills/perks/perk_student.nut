::mods_hookExactClass("skills/perks/perk_student", function(o) {
	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().getLevel() < 99)
		{
			_properties.XPGainMult *= 1.2;
		}
	}
});