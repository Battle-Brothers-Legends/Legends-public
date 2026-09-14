::mods_hookExactClass("factions/actions/send_barbarian_roamers_action", function (o) {
	o.onUpdate = function (_faction) {
		local settlements = _faction.getSettlements();

		if (settlements.len() <= 6) {
			return;
		}

		if (::World.FactionManager.isCivilWar()) {
			if (_faction.getUnits().len() >= 4) {
				return;
			}
		} else if (::World.FactionManager.isGreaterEvil()) {
			if (_faction.getUnits().len() >= 2) {
				return;
			}
		} else if (_faction.getUnits().len() >= 3) {
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
			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
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
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Barbarians", false, ::Const.World.Spawn.BarbarianHunters, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of barbarians out to hunt game.");
		party.setFootprintType(::Const.World.FootprintsType.Barbarians);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 5);
		party.getLoot().Medicine = ::Math.rand(0, 3);
		party.getLoot().Ammo = ::Math.rand(10, 30);

		if (::Math.rand(1, 100) <= 25) {
			party.addToInventory("loot/bone_figurines_item");
		}

		if (::Math.rand(1, 100) <= 25) {
			party.addToInventory("loot/bead_necklace_item");
		}

		if (::Math.rand(1, 100) <= 25) {
			party.addToInventory("loot/valuable_furs_item");
		}

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
