this.legends_druid_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_druid";
		this.m.Name = "Druid [Legacy]";
		this.m.Description = "[p=c][img]gfx/ui/events/event_25.png[/img][/p][p]The druids of the wild woods are wary of humans, prefering the company of beasts \n\n[color=#bcad8c]Wildform:[/color] Can take on the form of beasts in battle.\n[color=#bcad8c]Solitary:[/color] The Druid hates nearly all humans except wildlings, herbalists and practictioners of wild magic \n[color=#bcad8c]Avatar:[/color] If your druid dies, its game over.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 110;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
	}

	function isValid()
	{
		// return this.Const.DLC.Wildmen;
		return false;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 1; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"legend_druid_commander_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% has only ever known the wild woods, the worlds of men are strange and disgusting";
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
		::Legends.Perks.grant(bros[0], ::Legends.Perk.LegendRoots);
		//local r = this.Math.rand(1,99);
		//
		//if (r <= 50 )
		//{
		//	bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
		//	this.logDebug(this.getName() + " gained lycanthropy");
		//}
		//
		//if (r > 50 && r <= 80)
		//{
		//	bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
		//	this.logDebug(this.getName() + " gained aperthropy");
		//}
		//
		//if (r > 80 && r <= 95)
		//{
		//	bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_ursathropy_injury"));
		//	this.logDebug(this.getName() + " gained ursathropy");
		//}
		//
		//if (r > 95 && r <= 98)
		//{
		//	bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_arborthropy_injury"));
		//	this.logDebug(this.getName() + " gained arborthropy");
		//}
		//
		//if (r == 99)
		//{
		//	bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
		//	this.logDebug(this.getName() + " gained vermesthropy");
		//}
		this.World.Assets.m.Money = this.World.Assets.m.Money * 0.5;

		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_fresh_fruit_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/roots_and_berries_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/pickled_mushrooms_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_apothecary_mushrooms_item"));
		//this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_therianthropy_potion_item"));
		//this.World.Assets.getStash().add(this.new("scripts/items/misc/legend_wolfsbane_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/legend_mistletoe_item"));
	}

	function onSpawnPlayer()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Forest && tile.Type != this.Const.World.TerrainType.SnowyForest && tile.Type != this.Const.World.TerrainType.LeaveForest && tile.Type != this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);


		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", spawnTile.Coords.X, spawnTile.Coords.Y);
		this.World.Assets.updateLook(115);
		//this.World.State.m.Player.getSprite("body").setBrush("figure_player_druid");
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_druid_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsDruid", true);
	}
	function getMovementSpeedMult(){
		return 1.057;
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


	function onHiredByScenario( bro )
	{


	}

	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "legend_druid_background", 8);
		local bros = _roster.getAll();
		local garbage = [];
		foreach( i, bro in bros )
		{
			local r;
			r = this.Math.rand(0, 19);
			if (r == 0)
			{
				bro.TherianthropeInfectionRandom()
			}
			else
			{
				garbage.push(bro);
			}

		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onGenerateBro(bro)
	{
		if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.legend_herbalist"  || bro.getBackground().getID() == "background.legend_druid"  || bro.getBackground().getID() == "background.houndmaster"  || bro.getBackground().getID() == "background.legend_muladi"  || bro.getBackground().getID() == "background.legend_conjurer"  || bro.getBackground().getID() == "background.legend_enchanter" || bro.getBackground().getID() == "background.legend_runesmith"  || bro.getBackground().getID() == "background.legend_entrancer"  || bro.getBackground().getID() == "background.legend_donkey"  || bro.getBackground().getID() == "background.legend_spiritualist")
		{
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.8);
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.8);
		}
	}

});

