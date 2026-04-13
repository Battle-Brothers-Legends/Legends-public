::mods_hookDescendants("ambitions/ambition", function(o) {
	if ("onUpdateScore" in o) {
		local onUpdateScore = o.onUpdateScore;
		o.onUpdateScore = function() {
			local exludedAmbitions = ::World.Assets.getOrigin().getExcludedAmbitions();
			if (exludedAmbitions.find(this.m.ID) != null) {
				this.m.IsDone = true;
				return;
			}
			onUpdateScore();
		}
	}
});
