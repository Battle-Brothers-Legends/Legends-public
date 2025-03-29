::mods_hookExactClass("events/events/crisis/undead_frozen_pond_event", function(o) {
	o.onUpdateScore = function () {
		if (!this.World.FactionManager.isUndeadScourge())
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
			return;

		if (currentTile.HasRoad)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
			if (t.getTile().getDistanceTo(currentTile) <= 6) {
				nearTown = true;
				break;
			}

		if (nearTown)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_lightweight = [];
		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getCurrentProperties().getInitiative() >= 130)
				candidates_lightweight.push(bro);
			else
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		if (candidates_lightweight.len() > 0)
			this.m.Lightweight = candidates_lightweight[this.Math.rand(0, candidates_lightweight.len() - 1)];

		this.m.Other = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 20;
	}
})
