::mods_hookExactClass("factions/actions/send_orc_marauders_action", function(o)
{
	o.onExecute = function ( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		if (settlements.len() == 0)
		{
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local mult = this.World.FactionManager.isGreenskinInvasion() ? 1.1 : 1.0;
		if (::Legends.isLegendaryDifficulty())
			{
			local mult = this.World.FactionManager.isGreenskinInvasion() ? 1.2 : 1.0;
			}
		local rand = this.Math.rand(75, 120);
		//	local nearestOrcs = this.getNearestLocationTo(origin, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements());
		//		if (::Legends.isLegendaryDifficulty() && nearestOrcs > 28)
		//		{
		//			rand *= nearestOrcs / 28.0;
		//		}
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());
			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
				rand *= distanceToNextSettlement / 14.0;
			}
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, rand * this.getReputationToDifficultyLightMult() * mult);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
		party.setFootprintType(this.Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/strange_meat_item");
		}

		local c = party.getController();
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	}
});
