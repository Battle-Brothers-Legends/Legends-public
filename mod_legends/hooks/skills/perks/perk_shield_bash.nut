::mods_hookExactClass("skills/perks/perk_shield_bash", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		m.ID = "perk.shield_bash_legend"; // change id for greater purpose
	}

});
