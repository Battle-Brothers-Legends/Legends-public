::mods_hookExactClass("items/weapons/polehammer", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1600;
	}

	o.addSkill <- function( _skill )
	{
		this.weapon.addSkill(_skill);

		if (_skill.getID() != "actives.batter")
			return;

		local skill = ::new("scripts/skills/actives/impale");
		skill.m.Icon = "skills/legend_halberd_impale.png";
		skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
		skill.m.Overlay = "legend_halberd_impale";
		skill.m.IsIgnoredAsAOO = true;
		weapon.addSkill(skill);
	}

});
