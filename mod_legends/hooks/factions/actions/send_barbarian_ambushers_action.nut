::mods_hookExactClass("factions/actions/send_barbarian_ambushers_action", function (o) {
	o.m.TimeBetweenSpawns <- 150.0;

	o.onUpdate = function (_faction) {
		local settlements = _faction.getSettlements();

		if (settlements.len() < 7) {
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
		} else if (_faction.getUnits().len() >= 4) {
			return;
		}

		local allowed = false;

		foreach (s in settlements) {
			if (s.getResources() == 0) {
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
			if (s.getResources() == 0) {
				continue;
			}

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
		local difficulty = ::Math.rand(75, 120) * this.getReputationToDifficultyLightMult() * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * (::World.FactionManager.isCivilWar() ? (::Legends.isLegendaryDifficulty() ? 1.2 : 1.1) : 1.0);
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Barbarians", false, ::Const.World.Spawn.Barbarians, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A warband of barbarian tribals.");
		party.setFootprintType(::Const.World.FootprintsType.Barbarians);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = ::Math.rand(0, 50);
		party.getLoot().ArmorParts = ::Math.rand(0, 10);
		party.getLoot().Medicine = ::Math.rand(0, 5);
		party.getLoot().Ammo = ::Math.rand(0, 30);

		if (::Math.rand(1, 100) <= 50) {
			party.addToInventory("loot/bone_figurines_item");
		}

		if (::Math.rand(1, 100) <= 50) {
			party.addToInventory("loot/bead_necklace_item");
		}

		local r = ::Math.rand(2, 5);

		if (r == 2) {
			party.addToInventory("supplies/roots_and_berries_item");
		} else if (r == 3) {
			party.addToInventory("supplies/dried_fruits_item");
		} else if (r == 4) {
			party.addToInventory("supplies/ground_grains_item");
		} else if (r == 5) {
			party.addToInventory("supplies/pickled_mushrooms_item");
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
