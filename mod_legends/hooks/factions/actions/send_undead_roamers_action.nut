::mods_hookExactClass("factions/actions/send_undead_roamers_action", function (o) {
	o.onUpdate = function (_faction) {
		if (::World.getTime().Days < 20) {
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 6) {
			return;
		}

		if (_faction.getUnits().len() >= 3) {
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

		this.m.Score = ::World.Assets.getOrigin().getID() == "scenario.legends_inquisition" ? 15 : 10;
	}

	o.onExecute = function (_faction) {
		local settlements = [];

		foreach (s in _faction.getSettlements()) {
			if (s.getRoamerSpawnList() == null) {
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

		if (settlements.len() == 0) {
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local difficulty = ::Math.max(settlement.getResources() * 0.75, ::Math.rand(60, 100) * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * this.getReputationToDifficultyLightMult());
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Undead", false, settlement.getRoamerSpawnList(), difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("Something seems wrong.");
		party.setFootprintType(::Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = ::Math.rand(0, 100);
		party.getLoot().ArmorParts = ::Math.rand(0, 10);
		local r = ::Math.rand(1, 3);

		if (r == 1) {
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		local roam = ::new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(::Const.World.TerrainType.Ocean, false);
		roam.setTerrain(::Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(::World.getTime().SecondsPerDay * 2);
		roam.setMinRange(1);
		roam.setMaxRange(5);
		c.addOrder(roam);
		local move = ::new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		c.addOrder(move);
		c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
	}
});
