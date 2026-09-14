::mods_hookExactClass("factions/actions/send_goblin_roamers_action", function (o) {
	o.onUpdate = function (_faction) {
		local settlements = _faction.getSettlements();

		if (settlements.len() <= 6) {
			return;
		}

		if (::World.FactionManager.isGreenskinInvasion()) {
			if (_faction.getUnits().len() >= 3) {
				return;
			}
		} else if (_faction.getUnits().len() >= 6) {
			return;
		}

		local allowed = false;

		foreach (s in _faction.getSettlements()) {
			if (s.getResources() < 100.0) {
				continue;
			}

			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			// don't spawn attackers if a threatening party is nearby
			if (::World.getAllEntitiesAtPos(s.getPos(), 400.0).filter(@(_,_entity) (_entity.isParty() && _entity.isAttackable() && _entity.isAttackableByAI() && !s.isAlliedWith(_entity))).len() > 0){
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
			if (s.getResources() < 100.0) {
				continue;
			}

			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local difficulty = ::Math.min(settlement.getResources(), ::Math.rand(50, 110) * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * this.getReputationToDifficultyLightMult());
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Goblin Hunters", false, ::Const.World.Spawn.GoblinRoamers, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of mischievous goblins, small but cunning and not to be underestimated.");
		party.setFootprintType(::Const.World.FootprintsType.Goblins);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 5);
		party.getLoot().Medicine = ::Math.rand(0, 3);
		party.getLoot().Ammo = ::Math.rand(10, 30);
		local numFood = ::Math.rand(1, 2);

		for (local i = 0; i < numFood; i++) {
			if (::Math.rand(1, 100) <= 50) {
				party.addToInventory("supplies/strange_meat_item");
			} else {
				party.addToInventory("supplies/roots_and_berries_item");
			}
		}

		local c = party.getController();
		local roam = ::new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(::Const.World.TerrainType.Ocean, false);
		roam.setTerrain(::Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(::World.getTime().SecondsPerDay * 2);
		c.addOrder(roam);
		local move = ::new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		c.addOrder(move);
		c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		return true;
	}
});
