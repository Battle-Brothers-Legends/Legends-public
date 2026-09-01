::mods_hookExactClass("factions/actions/defend_undead_action", function (o) {
	o.onUpdate = function (_faction) {
		if (this.World.getTime().IsDaytime) {
			return;
		}

		local settlements = [];
		local playerAt;
		local beastFaction = ::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID();

		foreach (s in _faction.getSettlements()) {
			if (s.getResources() == 0) {
				continue;
			}

			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			local entities = ::World.getAllEntitiesAtPos(s.getPos(), 300.0);
			foreach (e in entities) {
				if (e.isParty() && e.isAttackable() && e.isAttackableByAI() && !s.isAlliedWith(e) && e.getStrength() < s.getResources() * 0.66 * ::Const.World.Scaling.getDistanceScaling(this, s.getTile())) {
					if (e.getFaction() == beastFaction) {
						continue;
					}

					if (e.isPlayerControlled()) {
						playerAt = s;
					}

					settlements.push(s);
					break;
				}
			}

			if (playerAt != null) {
				break;
			}
		}

		if (playerAt == null) {
			return;
		}

		if (playerAt != null && ::Math.rand(1, 100) > 10) {
			return;
		}

		if (playerAt != null || settlements.len() != 0) {
			this.m.Settlement = playerAt == null ? settlements[::Math.rand(0, settlements.len() - 1)] : playerAt;
			this.m.Score = 30;
		}
	}

	o.onExecute = function (_faction) {
		local spawnpoints = [];
		spawnpoints.push(this.m.Settlement.getTile());

		for (local i = 0; i < spawnpoints.len(); i++) {
			local party = this.getFaction().spawnEntity(spawnpoints[i], "Undead", false, this.m.Settlement.getRoamerSpawnList(), this.m.Settlement.getResources() * 0.66 * ::Const.World.Scaling.getDistanceScaling(this, this.m.Settlement.getTile()));
			party.getSprite("banner").setBrush(this.m.Settlement.getBanner());
			party.setDescription("Something seems wrong.");
			party.setFootprintType(::Const.World.FootprintsType.Undead);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = ::Math.rand(0, 100);
			party.getLoot().ArmorParts = ::Math.rand(0, 10);
			local c = party.getController();
			local guard = ::new("scripts/ai/world/orders/guard_order");
			guard.setTarget(spawnpoints[i]);
			guard.setTime(20.0);
			c.addOrder(guard);
			c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		}

		this.m.Settlement.setLastSpawnTimeToNow();
		return true;
	}
});
