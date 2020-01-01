this.legend_random_solo_scenario<- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legend_random_solo";
		this.m.Name = "Random Solo";
		this.m.Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]Striking out on your own, who knows what the world has in store? \n[color=#bcad8c]Random Backgrounds:[/color] Your background will be different each time you start\n[color=#bcad8c]Random equipment:[/color]The equipment you begin with is different each time\n[color=#bcad8c]Avatar:[/color]If you die, its game over[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 18;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}
	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 1; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.setStartValuesEx(this.Const.CharacterBackgroundsRandom);
		}

		local bros = roster.getAll();
		bros[0].m.PerkPoints = 3;
		bros[0].m.LevelUps = 3;
		bros[0].m.Level = 4;
		bros[0].setVeteranPerks(2);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getTags().set("IsPlayerCharacter", true);
		this.World.Assets.m.BusinessReputation = 100;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}


	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 1), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 1), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) == 0)
				{
				}
				else if (!tile.HasRoad)
				{
				}
				else
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(6);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_random_solo_scenario_intro");
		}, null);

		if(this.Const.LegendMod.Configs.LegendCampUnlockEnabled())
		{
			this.World.Tags.set("HasLegendCampGathering", true);
			this.World.Tags.set("HasLegendCampBarber", true);
			this.World.Tags.set("HasLegendCampCrafting", true);
			this.World.Tags.set("HasLegendCampFletching", true);
			this.World.Tags.set("HasLegendCampHealing", true);
			this.World.Tags.set("HasLegendCampHunting", true);
			this.World.Tags.set("HasLegendCampScouting", true);
			this.World.Tags.set("HasLegendCampScraping", true);
			this.World.Tags.set("HasLegendCampTraining", true);			
		}
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 18;
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getTags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

});

