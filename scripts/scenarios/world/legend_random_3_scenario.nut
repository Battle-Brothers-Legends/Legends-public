this.legend_random_3_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legend_random_3";
		this.m.Name = "Random Trio";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p][p]Having fled a raid, three fellows decide to forge out a new path.\n\n[color=#bcad8c]Random Backgrounds:[/color] The backgrounds are different each time you start.\n[color=#bcad8c]Random equipment:[/color] The equipment you begin with is different each time.\n[color=#bcad8c]Random perks:[/color] The abilities of your mercenaries will be different each time.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 220;
	}



	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.setStartValuesEx(this.Const.CharacterBackgroundsRandom);
		}

		local bros = roster.getAll();

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));

	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 2), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 2), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

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

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_random_3_scenario_intro");
		}, null);

	}



});

