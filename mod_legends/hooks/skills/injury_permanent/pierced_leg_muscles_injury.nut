this.mods_hookExactClass("skills/injury/pierced_leg_muscles_injury", function(o) {
	o.m.Cooldown <- 0;
	o.onAdded <- function ()
	{
		if (this.m.IsNew)
			this.m.Cooldown += 1;
	}

	o.onTurnEnd <- function()
	{
		if (this.m.Cooldown > 0)
			this.m.Cooldown -= 1;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		onUpdate(_properties);
		if (!this.m.IsNew || this.m.Cooldown == 0 || !_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
			return;

		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.65;
		_properties.RangedDefenseMult *= 0.65;
		_properties.InitiativeMult *= 0.65;
	}
});