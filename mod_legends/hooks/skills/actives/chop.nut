::mods_hookExactClass("skills/actives/chop", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.isHidden <- function()
	{
		return this.m.IsOrcWeapon && this.getContainer().getActor().getSkills().getSkillByID("special.double_grip").canDoubleGrip();
	}
});
