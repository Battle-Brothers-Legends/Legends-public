::mods_hookBaseClass("scenarios/world/starting_scenario", function(o) {
	o = o[o.SuperName];

	o.onNewDay <- function()
	{
	}

	o.onNewMorning <- function()
	{
	}

	o.getMovementSpeedMult <- function()
	{
		return 1.0;
	}
});
