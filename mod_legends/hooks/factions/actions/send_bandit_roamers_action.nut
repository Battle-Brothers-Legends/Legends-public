::mods_hookExactClass("factions/actions/send_bandit_roamers_action", function (o) {
	o.onUpdate = function (_faction) {
		local settlements = _faction.getSettlements();

		if (settlements.len() <= 6) {
			return;
		}

		if (::World.FactionManager.isCivilWar()) {
			if (_faction.getUnits().len() >= 6) {
				return;
			}
		} else if (::World.FactionManager.isGreaterEvil()) {
			if (_faction.getUnits().len() >= 3) {
				return;
			}
		} else if (_faction.getUnits().len() >= 5) {
			return;
		}

		local allowed = false;

		foreach (s in settlements) {
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

		this.m.Score = 5;
	}

	o.onExecute = function (_faction) {
		local settlements = [];

		foreach (s in _faction.getSettlements()) {
			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF() || s.getFlags().get("isContractLocation")) { //use to prevent patrols on camps that are marked by contracts.
				continue;
			}

			local activeContract = ::World.Contracts.getActiveContract();
			if (activeContract != null && "Destination" in activeContract.m && activeContract.m.Destination == s) {
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local difficulty = ::Math.min(settlement.getResources(), ::Math.rand(60, 110) * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true));
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Brigand Hunters", false, ::Const.World.Spawn.BanditRoamers, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A rough and tough band of brigands out to hunt for food.");
		party.setFootprintType(::Const.World.FootprintsType.Brigands);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = ::Math.rand(0, 100);
		party.getLoot().ArmorParts = ::Math.rand(0, 5);
		party.getLoot().Medicine = ::Math.rand(0, 3);
		party.getLoot().Ammo = ::Math.rand(10, 30);
		local numFood = ::Math.rand(1, 2);

		for (local i = 0; i < numFood; i++) {
			if (::Math.rand(1, 100) <= 50) {
				party.addToInventory("supplies/cured_venison_item");
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
