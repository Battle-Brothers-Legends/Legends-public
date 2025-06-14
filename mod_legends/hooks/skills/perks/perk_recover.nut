::mods_hookExactClass("skills/perks/perk_recover", function(o) {
	o.onTurnEnd <- function ()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 2));

	}
});