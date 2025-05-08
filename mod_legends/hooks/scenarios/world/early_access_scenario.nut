::mods_hookExactClass("scenarios/world/early_access_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.early_access";
		this.m.Name = "A New Company";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p][p]After years of bloodying your sword for meager pay, you\'ve saved enough crowns to start your very own mercenary company. With you are three experienced mercenaries with whom you\'ve fought side by side in the shieldwall before.\n\n[color=#bcad8c]A quick start into the world, without any particular advantages or disadvantages.[/color][/p]";
		this.m.Difficulty = 1;
		this.m.Order = 1;
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(1.5, "Joined a mercenary company");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"companion_1h_background"
		]);
		bros[0].getBackground().m.RawDescription = "{You saved %name%\'s life in a battle against brigands, and he returned the favor in an alley ambush by thieves. Given that common criminals are a few levels beneath brigands, you often joke with him that he is still a little behind on the \'saving each other\'s asses\' debt.}";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);

		bros[1].setStartValuesEx([
			"companion_2h_background"
		]);
		bros[1].getBackground().m.RawDescription = "{Whatever is wrong with %name% you hope he never fixes it. A character with a particular taste for battling, whoring, gambling, singing, dogfighting, skirt chasing, weirdly dish washing, vomiting and, of course, drinking, he has always been a gift to have around. He also just happens to be an excellent fighter in his own right.}";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);

		bros[2].setStartValuesEx([
			"companion_ranged_background"
		]);
		bros[2].getBackground().m.RawDescription = "You crossed paths with %name% a number of times prior to his joining the company. First time you were both simple laborers. The second time you were sellswords. And now is the third go of it with him joining your company. If all goes well, he\'ll finally stick around this time and you\'ll both find the riches you seek.";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money * 2;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
			{
				break;
			}
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
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.early_access_scenario_intro");
		}, null);
	}

});

