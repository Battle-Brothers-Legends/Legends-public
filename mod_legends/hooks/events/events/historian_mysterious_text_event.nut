::mods_hookExactClass("events/events/historian_mysterious_text_event", function(o) {
	o.onUpdateScore = function () {
		if (this.World.getTime().Days < 10)
			return;

		local town = ::Legends.S.getClosestSettlement();
		if (town == null || town.getTile().getDistanceTo(::World.State.getPlayer().getTile()) > 8)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_historian = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && (::Legends.Backgrounds.has(bro, ::Legends.Background.Historian) || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))) {
				candidates_historian.push(bro);
			}
		}

		if (candidates_historian.len() == 0)
			return;

		this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		this.m.Score = 5;
	}
})
