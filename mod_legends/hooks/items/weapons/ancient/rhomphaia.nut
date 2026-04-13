::mods_hookExactClass("items/weapons/ancient/rhomphaia", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.IsGreatBreachSlash = true;

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendIntoTheFray);
	}
});
