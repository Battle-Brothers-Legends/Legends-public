::mods_hookExactClass("factions/actions/send_orc_marauders_action", function (o) {
	o.onUpdate = function (_faction) {
		if (::World.getTime().Days <= 5) {
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 7) {
			return;
		}

		if (::World.FactionManager.isGreenskinInvasion() && ::World.FactionManager.getGreaterEvilStrength() >= 10.0) {
			if (_faction.getUnits().len() >= 7) {
				return;
			}
		} else if (_faction.getUnits().len() >= 4) {
			return;
		}

		local allowed = false;

		foreach (s in settlements) {
			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			allowed = true;
			break;
		}

		if (!allowed) {
			return;
		}

		this.m.Score = 10;
	}

	o.onExecute = function (_faction) {
		local settlements = [];

		foreach (s in _faction.getSettlements()) {
			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		if (settlements.len() == 0) {
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local difficulty = ::Math.rand(75, 120) * this.getReputationToDifficultyLightMult() * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * (::World.FactionManager.isGreenskinInvasion() ? (::Legends.isLegendaryDifficulty() ? 1.2 : 1.1) : 1.0);
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Orc Marauders", false, ::Const.World.Spawn.OrcRaiders, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
		party.setFootprintType(::Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 15);
		local numFood = ::Math.rand(1, 2);

		for (local i = 0; i < numFood; i++) {
			party.addToInventory("supplies/strange_meat_item");
		}

		local c = party.getController();
		c.addOrder(::new("scripts/ai/world/orders/ambush_order"));
		local move = ::new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		c.addOrder(move);
		c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		return true;
	}
});
