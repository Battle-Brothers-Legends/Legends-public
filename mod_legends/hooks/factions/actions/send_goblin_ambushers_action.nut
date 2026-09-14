::mods_hookExactClass("factions/actions/send_goblin_ambushers_action", function (o) {
	o.m.TimeBetweenSpawns <- 150.0;

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

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local difficulty = ::Math.rand(75, 120) * this.getScaledDifficultyMult() * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * (::World.FactionManager.isGreenskinInvasion() ? (::Legends.isLegendaryDifficulty() ? 1.2 : 1.1) : 1.0);
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Goblin Raiders", false, ::Const.World.Spawn.GoblinRaiders, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of mischievous goblins, small but cunning and not to be underestimated.");
		party.setFootprintType(::Const.World.FootprintsType.Goblins);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 10);
		party.getLoot().Medicine = ::Math.rand(0, 3);
		party.getLoot().Ammo = ::Math.rand(10, 30);

		if (::Math.rand(1, 100) <= 75) {
			local loot = [
				"supplies/strange_meat_item",
				"supplies/roots_and_berries_item",
				"supplies/pickled_mushrooms_item"
			];
			party.addToInventory(loot[::Math.rand(0, loot.len() - 1)]);
		}

		if (this.Math.rand(1, 100) <= 33) {
			local loot = [
				"loot/goblin_carved_ivory_iconographs_item",
				"loot/goblin_minted_coins_item",
				"loot/goblin_rank_insignia_item"
			];
			party.addToInventory(loot[::Math.rand(0, loot.len() - 1)]);
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
