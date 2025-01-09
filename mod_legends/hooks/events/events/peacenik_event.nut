::mods_hookExactClass("events/events/peacenik_event", function(o) {
	o.onUpdateScore = function () {
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi" || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar)) )
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}
})
