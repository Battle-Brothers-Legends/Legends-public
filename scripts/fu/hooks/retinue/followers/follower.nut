::mods_hookBaseClass("retinue/follower", function(o) {
	o = o[o.SuperName];
	o.getMovementSpeedMult <- function()
	{
		return 1.0;
	}
})
