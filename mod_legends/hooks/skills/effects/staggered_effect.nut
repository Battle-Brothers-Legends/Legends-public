::mods_hookExactClass("skills/effects/staggered_effect", function(o) {
	
	local create = o.create
	o.create = function()
	{
		create();
		this.m.Overlay = "";
	}

	local onAdded = o.onAdded;
	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().get("CanNotBeStaggered") || !actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}

		this.m.Overlay = "status_effect_65";
		this.spawnIcon(this.m.Overlay, _c.getActor().getTile());
		onAdded();
	}

	o.onRefresh = function ()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
		local tile = this.getContainer().getActor().getTile();
		if (tile != null)
		{
			this.spawnIcon("status_effect_65", this.getContainer().getActor().getTile());
		}
	}
});