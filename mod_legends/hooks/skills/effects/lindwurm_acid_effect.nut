::mods_hookExactClass("skills/effects/lindwurm_acid_effect", function(o) {

	local onAdded = o.onAdded;
	o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ::FU.HasTacticalState() && ::FU.IsBattleEnded())
		{
			this.removeSelf();
			return;
		}
		onAdded();
	}
});
