::mods_hookExactClass("factions/actions/rebuild_location_action", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function (_faction) {
		if (::Math.rand(1, 100) > 10) {
			return;
		}

		if (::World.Contracts.getActiveContract() != null && ::World.Contracts.getActiveContract().getID() == "contract.raze_attached_location") {
			return;
		}

		this.m.Settlement = _faction.getSettlements()[::Math.rand(0, _faction.getSettlements().len() - 1)];

		if (_faction.getType() == ::Const.FactionType.NobleHouse && !this.m.Settlement.isMilitary()) {
			return;
		}

		if (this.m.Settlement.getTile().getDistanceTo(::World.State.getPlayer().getTile()) <= 15) { //should use ::Math.max(15, ::Math.ceil(::World.State.getPlayer().getVisionRadius() * DistanceToTilesFactor)) + ~3 tiles to cover the location spawning range from settlement instead of plain 15 to cover edge cases with scouting tent
			return;
		}

		if (this.m.Settlement.isBuilding()) {
			return;
		}

		local numInactive = 0;
		local nogo = false;

		foreach (a in this.m.Settlement.getAttachedLocations()) {
			if (a.isActive()) {
				continue;
			}

			if (a.isBuilding()) {
				nogo = true;
				break;
			}

			numInactive = ++numInactive;
		}

		if (nogo) {
			return;
		}

		if (numInactive == 0) {
			return;
		}

		this.m.Score = 1;
	}
});
