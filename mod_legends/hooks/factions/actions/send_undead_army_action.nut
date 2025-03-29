::mods_hookExactClass("factions/actions/send_undead_army_action", function(o) 
{
	o.m.timeBetweenSpawnsPerSettlement <- 150;

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _faction )
	{
		onUpdate(_faction);
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
		{
			this.m.Score = 15;
		}
	}

	o.onExecute = function ( _faction )
	{
		local potential_origins = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			potential_origins.push({
				D = s,
				P = s.getResources()
			});
		}

		if (potential_origins.len() == 0)
		{
			return;
		}

		local origin = this.pickWeightedRandom(potential_origins);
		local myTile = origin.getTile();
		local activeContract = this.World.Contracts.getActiveContract();
		local settlements = this.World.EntityManager.getSettlements();
		local lowest_distance = 99999;
		local best_settlement;

		foreach( s in settlements )
		{
			if (activeContract != null && (activeContract.getHome().getID() == s.getID() || activeContract.getOrigin().getID() == s.getID()))
			{
				continue;
			}

			local d = myTile.getDistanceTo(s.getTile());

			if (s.hasSituation("situation.razed"))
			{
				d = d + 20;
			}

			if (d <= lowest_distance && !s.isIsolatedFromLocation(origin))
			{
				if (s.isSouthern())
				{
					local skip = true;

					foreach( l in s.getAttachedLocations() )
					{
						if (l.isActive() && l.isUsable())
						{
							skip = false;
							break;
						}
					}

					if (skip)
					{
						continue;
					}
				}

				lowest_distance = d;
				best_settlement = s;
			}
		}

		if (best_settlement == null)
		{
			return;
		}

		local locations = best_settlement.getAttachedLocations();
		local targets = [];

		foreach( l in locations )
		{
			if (l.isActive() && l.isUsable())
			{
				targets.push(l);
			}
		}

		local nearestUndead = this.getNearestLocationTo(origin, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements());
		local rand = this.Math.rand(80, 120);
		local distanceToNextSettlement = this.getDistanceToSettlements(best_settlement.getTile());
		if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
		{
			rand *= distanceToNextSettlement / 14.0;
		}
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(myTile, "Undead", false, this.Const.World.Spawn.UndeadScourge, rand * this.getScaledDifficultyMult());
		party.getSprite("banner").setBrush(nearestUndead.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);

		if (targets.len() != 0)
		{
			local target = targets[this.Math.rand(0, targets.len() - 1)];
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(40.0);
			raid.setTargetTile(target.getTile());
			c.addOrder(raid);
			local back = this.new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(despawn);
		}
		else
		{
			local target = best_settlement;
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local destroy = this.new("scripts/ai/world/orders/convert_order");
			destroy.setTime(60.0);
			destroy.setTargetTile(target.getTile());
			destroy.setTargetID(target.getID());
			c.addOrder(destroy);
			local back = this.new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(despawn);
		}

		return true;
	}
});