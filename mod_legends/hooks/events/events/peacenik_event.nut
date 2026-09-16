::mods_hookExactClass("events/events/peacenik_event", function(o) {
	o.onUpdateScore = function () {
		local currentTile = ::World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && (::Legends.Backgrounds.hasAny(bro, ::Legends.Background.Houndmaster, ::Legends.Background.LegendMuladi) || ::Legends.Professions.has(bro, ::Legends.Profession.LegendScholar)))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Houndmaster = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}
})
