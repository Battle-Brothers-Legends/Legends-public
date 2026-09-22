this.legends_beggar_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_beggar";
		this.m.Name = "Beggar";
		this.m.Description = "[p=c][img]gfx/ui/events/event_70.png[/img][/p][p]A lowly unskilled beggar, you witnessed something in an alley and now a noble house wants you dead. This is a challenge run with a very weak starting character. \n\n[color=#bcad8c]Knows Too Much:[/color] All noble houses hate you.\n[color=#bcad8c]Begin alone Avatar[/color]: If the beggar dies, the campaign ends.\n[color=#bcad8c]Dirty Peasant[/color]: You can only hire lowerborn backgrounds.[/p]";
		this.m.Difficulty = 3;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(1);
		this.m.StartingBusinessReputation = -200; // Still use default reputation tiers even if starting at negative reputation
		this.starting_scenario.create();
	}



	function onSpawnAssets() {
		local bro;
		bro = ::World.getPlayerRoster().create("scripts/entity/tactical/player");
		bro.m.HireTime = ::Time.getVirtualTimeF();
		bro.setName(::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]);
		bro.setStartValuesEx([::Legends.Background.LegendCommanderBeggar]);
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.worsenMood(1.5, "Saw something awful");

		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.getStash().resize(::World.Assets.getStash().getCapacity() + 9);
		::World.Assets.m.Money = ::World.Assets.m.Money / 2 + 2;
		::World.Assets.m.ArmorParts = 0;
		::World.Assets.m.Medicine = 0;
		::World.Assets.m.Ammo = 0;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != ::World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() == 1)
			{
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		::World.Flags.set("HomeVillage", randomVillage.getName());
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;
		local f = randomVillage.getFactionOfType(::Const.FactionType.NobleHouse);
		f.addPlayerRelation(-200.0, "You know too much");

		do
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 4), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 4), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!::World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else if (tile.Type != ::Const.World.TerrainType.Plains && tile.Type != ::Const.World.TerrainType.Steppe && tile.Type != ::Const.World.TerrainType.Tundra && tile.Type != ::Const.World.TerrainType.Snow)
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

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(111);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		randomVillage.getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(40.0, "Considered local heroes for keeping the village safe");
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			::Music.setTrackList([
				"music/retirement_01.ogg"
			], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_beggar_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
	}

	function onCombatFinished()
	{
		local roster = ::World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

	function onHiredByScenario( _bro )
	{
		if (!_bro.getBackground().isBackgroundType(::Const.BackgroundType.Lowborn) && !_bro.isStabled())
		{
			_bro.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
			_bro.worsenMood(1.0, "Fell sick after joining you");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (!bro.getBackground().isBackgroundType(::Const.BackgroundType.Lowborn))
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

});

