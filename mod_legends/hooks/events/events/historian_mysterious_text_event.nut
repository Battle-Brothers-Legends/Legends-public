::mods_hookExactClass("events/events/historian_mysterious_text_event", function(o) {
	o.onUpdateScore = function () {
		if (this.World.getTime().Days < 10)
			return;

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns ) {
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 8) {
				nearTown = true;
				break;
			}
		}

		if (nearTown)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_historian = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && (bro.getBackground().getID() == "background.historian" || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))) {
				candidates_historian.push(bro);
			}
		}

		if (candidates_historian.len() == 0)
			return;

		this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		this.m.Score = 5;
	}
})
