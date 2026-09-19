this.legends_custom_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_custom_party";
		this.m.Name = "Build your own ";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p]Build and customize your company roster (Your very own pick and choose adventure!)";
		this.m.Difficulty = 3;
		this.m.Order = 99;
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function isValid()
	{
		return false; //::Const.LegendMod.DebugMode;
	}


	function onSpawnAssets()
	{
		local roster = ::World.getPlayerRoster();
		local bro = roster.create("scripts/entity/tactical/player");
		bro.m.HireTime = ::Time.getVirtualTimeF();
		bro.setStartValuesEx(::Const.CharacterBackgroundsRandom);

		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));
		::World.Assets.m.Money = ::World.Assets.m.Money * 3;
	}


	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != ::World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = ::World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 2), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 2), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!::World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = ::World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_custom_scenario_intro");
		}, null);
	}
});

