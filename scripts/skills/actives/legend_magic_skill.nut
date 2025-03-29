// This should help manage the resolve scaling
this.legend_magic_skill <- this.inherit("scripts/skills/skill", {
	m = {
	// Resolve needed to increment effect by 1
	ResolveScaling = 1,
	// Resolve before it starts to increment
	ResolveCuttoff = 50
	},

	function create()
  {
	// This should probably never get called
	}

  function getTooltip()
	{
		return this.getDefaultTooltip();
	}

  // By default magic skills are unusable in melee, and they need a staff to be used.
  function isUsable()
	{
	if (!this.getContainer().getActor().isArmedWithMagicStaff())
		{
			return false;
		}
  
		return this.skill.isUsable() && (!this.Tactical.isActive() || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()));
	}

  function getCurrentResolve()
  {
	return this.getContainer().getActor().getCurrentProperties().getBravery();
  }

  // Return floor((Resolve - ResolveCuttoff)/ResolveScaling)
  function getResolveScaling()
  {
	local resolve = this.getCurrentResolve();
	local resolveDifference = resolve - this.m.ResolveCuttoff;
	if (resolveDifference <= 0)
	{
	  return 0;
	}
	local scaling = resolveDifference / this.m.ResolveScaling;
	if (typeof scaling == "float") return scaling.tointeger();
	return scaling;
  }
	
});