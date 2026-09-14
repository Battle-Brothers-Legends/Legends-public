::mods_hookExactClass("items/weapons/ancient/rhomphaia", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendBreach, function (_skill) {
				_skill.m.IsGreatBreachSlash = true;
			}.bindenv(this));
			return;

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendIntoTheFray);
	}
});
