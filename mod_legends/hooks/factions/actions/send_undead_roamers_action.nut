::mods_hookExactClass("factions/actions/send_undead_roamers_action", function(o) 
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
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getRoamerSpawnList() == null)
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

		if (settlements.len() == 0)
		{
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local rand = this.Math.rand(60, 100);
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());
			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
				rand *= distanceToNextSettlement / 14.0;
			}
		local party = this.getFaction().spawnEntity(settlement.getTile(), "Undead", false, settlement.getRoamerSpawnList(), this.Math.max(settlement.getResources() * 0.75, this.Math.rand(60, 100) * this.getReputationToDifficultyLightMult()));
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("Something seems wrong.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 100);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(this.World.getTime().SecondsPerDay * 2);
		roam.setMinRange(1);
		roam.setMaxRange(5);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
	}
});