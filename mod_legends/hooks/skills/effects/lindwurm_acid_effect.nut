::mods_hookExactClass("skills/effects/lindwurm_acid_effect", function(o) {
	
	local onAdded = o.onAdded;
	o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
		onAdded();
	}
});