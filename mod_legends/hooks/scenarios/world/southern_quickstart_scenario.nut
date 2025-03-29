::mods_hookExactClass("scenarios/world/southern_quickstart_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.southern_quickstart";
		this.m.Name = "Southern Mercenaries";
		this.m.Description = "[p=c][img]gfx/ui/events/event_156.png[/img][/p][p]You and your small band of mercenaries have done the dirty work of small-time merchants for years, yet you are barely a step above brigands. You want to be bigger than that. You want it all. And the Gilder will reveal the way to you.\n\n[color=#bcad8c]A quick start into the southern part of the world, without any particular advantages or disadvantages.[/color][/p]";
		this.m.Difficulty = 1;
		this.m.Order = 270;
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(1.5, "Joined a mercenary company");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"companion_1h_southern_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% was once in a Vizier\'s elite vanguard. A pitched battle saw the entire legion annihilated and %name% buried beneath their bodies. Abandoned to the desert, %name% survived by means that even to this day shall not be told. But the unerring loyalty to you speaks more than any war story ever could.}";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);

		bros[1].setStartValuesEx([
			"companion_2h_southern_background"
		]);
		bros[1].getBackground().m.RawDescription = "{If loyalty was gold, this might be the wealthiest person to stand beneath the Gilder\'s eye. You found %name% being ambushed in an alley and promptly fought off the thieves. The southerner swore allegiance to you for one year. And it has been many since. Despite a lousy first fighting impression, %name% is a formidable warrior when not getting bushwhacked.}";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);

		bros[2].setStartValuesEx([
			"companion_ranged_southern_background"
		]);
		bros[2].getBackground().m.RawDescription = "{You are not entirely sure of %name%\'s past, only that the path traveled has not had as much shine as one would hope. %name% has attempted to live many lives, but the army said no, the city guard refused and the brothels closed their doors shut. A life as a Crownling it is then. %name% thinks a glorious and hastened death will mean a faster trip to the Gilder\'s eye so the two of them can discuss why exactly the life lived was so troublesome. When the southerner is not moping about, %name% can be cheerful and funny. Just keep the mercenary away from drinks and priests.}";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 400;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern())
			{
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

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

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(13);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.southern_quickstart_scenario_intro");
		}, null);
	}

});

