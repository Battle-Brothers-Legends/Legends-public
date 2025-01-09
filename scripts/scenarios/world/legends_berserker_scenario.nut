this.legends_berserker_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_berserker";
		this.m.Name = "Berserker";
		this.m.Description = "[p=c][img]gfx/ui/events/event_139.png[/img][/p][p]You are a barbarian berserker, driven by an unbound rage. Watching your family be slaughtered drove you into a self-destructive frenzy of violence and revenge.\n\n[color=#bcad8c]Berserker Madness:[/color] Unlock powerful abilities that allow you to fight naked and bare-handed.\n[color=#bcad8c]Infectious Rage:[/color] Only the insane, violent or desperate will join you. You will grant the Berserk perk to anyone who joins you in battle. You have a tiny chance of finding other berserkers for hire.\n[color=#bcad8c]Avatar:[/color] Begin alone. If you die, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 60;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
	}



	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 1; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
		}
		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_berserker_commander_background"
		]);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.Berserk);
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setVeteranPerks(2);
		this.World.Assets.m.Money = this.World.Assets.m.Money;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo;
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}

			i = ++i;
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
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local houses = [];

		foreach( n in nobles )
		{
			local closest;
			local dist = 9999;

			foreach( s in n.getSettlements() )
			{
				local d = s.getTile().getDistanceTo(randomVillageTile);

				if (d < dist)
				{
					dist = d;
					closest = s;
				}
			}

			houses.push({
				Faction = n,
				Dist = dist
			});
		}

		houses.sort(function ( _a, _b )
		{
			if (_a.Dist > _b.Dist)
			{
				return 1;
			}
			else if (_a.Dist < _b.Dist)
			{
				return -1;
			}

			return 0;
		});

		for( local i = 0; i < 2; i = i )
		{
			houses[i].Faction.addPlayerRelation(-30.0, "You are considered a barbarian");
			i = ++i;
		}

		houses[1].Faction.addPlayerRelation(18.0);
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(106);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/barbarians_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_berserker_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsBerserker", true);
	}

	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

	function onUpdateHiringRoster( _roster )
	{
		// this.addBroToRoster(_roster, "wildwoman_background", 8)
		this.addBroToRoster(_roster, "wildman_background", 10)
		this.addBroToRoster(_roster, "barbarian_background", 7)
		this.addBroToRoster(_roster, "legend_berserker_background", 9)
	}

	function onGenerateBro(bro)
	{
		if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat)) // Added this check for backgrounds like retired soldier
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25) //1.0 = default
				bro.getBaseProperties().DailyWageMult *= 1.25; //1.0 = default
				bro.getSkills().update();
			}
		else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9) //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.9; //1.0 = default
			bro.getSkills().update();
		}
	}


	function onHiredByScenario( bro )
	{
		if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
		{
			bro.worsenMood(1.5, "Disturbed by your wild and erratic nature");
		}
		else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
		{
			bro.improveMood(1.0, "Excited by your lust for battle");
		}

		bro.improveMood(0.5, "Learned a new skill");
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Berserk);
	}

});

