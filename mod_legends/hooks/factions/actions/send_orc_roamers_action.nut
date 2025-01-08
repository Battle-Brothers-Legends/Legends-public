::mods_hookExactClass("factions/actions/send_orc_roamers_action", function(o)
{
	o.onExecute = function ( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() < 100.0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local rand = this.Math.rand(50, 100);
		//	local nearestOrcs = this.getNearestLocationTo(settlement, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements());
		//		if (::Legends.isLegendaryDifficulty() && nearestOrcs > 28)
		//		{
		//			rand *=  nearestOrcs / 28.0;
		//		}
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());
			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
				 rand *= distanceToNextSettlement / 14.0;
			}
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Orc Hunters", false, this.Const.World.Spawn.OrcRoamers, this.Math.min(settlement.getResources(), rand) * this.getReputationToDifficultyLightMult());
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
		party.setFootprintType(this.Const.World.FootprintsType.Orcs);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		local numFood = this.Math.rand(2, 3);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/strange_meat_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(this.World.getTime().SecondsPerDay * 2);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
	}
});
