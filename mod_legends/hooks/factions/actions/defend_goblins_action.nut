::mods_hookExactClass("factions/actions/defend_goblins_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		local settlements = [];
		local playerAt;
		local beastFaction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID();

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() == 0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			local mult = 0.66;
			local distanceToNextSettlement = this.getDistanceToSettlements(s.getTile());

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
				mult *= distanceToNextSettlement / 14.0;
			}

			local entities = this.World.getAllEntitiesAtPos(s.getPos(), 400.0);

			foreach( e in entities )
			{

				if (e.isParty() && e.isAttackable() && e.isAttackableByAI() && !s.isAlliedWith(e) && e.getStrength() < s.getResources() * mult)
				{
					if (e.getFaction() == beastFaction && this.Math.rand(1, 100) > 10)
					{
						continue;
					}

					if (e.isPlayerControlled())
					{
						playerAt = s;
					}

					settlements.push(s);
					break;
				}
			}

			if (playerAt != null)
			{
				break;
			}
		}

		if (playerAt != null && this.Math.rand(1, 100) > 20)
		{
			return;
		}

		if (playerAt != null || settlements.len() != 0)
		{
			this.m.Settlement = playerAt == null ? settlements[this.Math.rand(0, settlements.len() - 1)] : playerAt;
			this.m.Score = 30;
		}
	}

	o.onExecute = function ( _faction )
	{
		local spawnpoints = [];
		spawnpoints.push(this.m.Settlement.getTile());

		for( local i = 0; i != spawnpoints.len(); i = ++i )
		{
			local mult = 0.66;
			local distanceToNextSettlement = this.getDistanceToSettlements(this.m.Settlement.getTile());
			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
				mult *= distanceToNextSettlement / 14.0;
			}
			local party = this.getFaction().spawnEntity(spawnpoints[i], "Goblins", false, this.Const.World.Spawn.GoblinDefenders, this.m.Settlement.getResources() * mult);
			party.setDescription("A band of mischievous goblins, small but cunning and not to be underestimated.");
			party.getSprite("banner").setBrush(this.m.Settlement.getBanner());
			party.setFootprintType(this.Const.World.FootprintsType.Goblins);
			party.getFlags().set("IsRandomlySpawned", true);
			local c = party.getController();
			local guard = this.new("scripts/ai/world/orders/guard_order");
			guard.setTarget(spawnpoints[i]);
			guard.setTime(20.0);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(guard);
			c.addOrder(despawn);
		}

		this.m.Settlement.setLastSpawnTimeToNow();
		return true;
	}
});