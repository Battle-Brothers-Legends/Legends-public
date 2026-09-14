::mods_hookExactClass("factions/actions/send_undead_ambushers_action", function (o) {
	o.m.TimeBetweenSpawns <- 150.0;

	function onUpdate(_faction) {
		if (!(this.World.FactionManager.getGreaterEvilType() == ::Const.World.GreaterEvilType.Undead && ::World.FactionManager.getGreaterEvilPhase() >= ::Const.World.GreaterEvilPhase.Warning)) {
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 7) {
			return;
		}

		if (::World.FactionManager.getGreaterEvilPhase() == ::Const.World.GreaterEvilPhase.Live && ::World.FactionManager.getGreaterEvilStrength() >= 10.0) {
			if (_faction.getUnits().len() >= 6) {
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

		this.m.Score = ::World.Assets.getOrigin().getID() == "scenario.legends_inquisition" ? 15 : 10;
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
		local difficulty = ::Math.rand(75, 120) * this.getScaledDifficultyMult() * ::Const.World.Scaling.getDistanceScaling(this, settlement.getTile(), true) * (::World.FactionManager.isUndeadScourge() ? (::Legends.isLegendaryDifficulty() ? 1.2 : 1.1) : 1.0);
		local party = _faction.spawnEntity(settlement.getTile(), "Undead", false, ::Const.World.Spawn.UndeadScourge, difficulty);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(::Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 15);
		local r = ::Math.rand(1, 3);

		if (r == 1) {
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.addOrder(::new("scripts/ai/world/orders/ambush_order"));
		local move = ::new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		c.addOrder(move);
		c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		return true;
	}
});
