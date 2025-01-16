this.legends_crusader_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_crusader";
		this.m.Name = "Crusader";
		this.m.Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]Sent on a holy quest to rid the world of undead, you walk a righteous path. \n\n[color=#bcad8c]Pure of Heart:[/color] You cannot recruit outlaw backgrounds, while pious recruits and squires cost less.\n[color=#bcad8c]Strict Sermons:[/color] You will grant the Fortified Mind perk to any pious background that joins you. Find Pilgrims to aid you on your journey.\n[color=#bcad8c]Avatar:[/color] If your crusader dies, the campaign ends.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 70;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
		this.m.StartingBusinessReputation = 1150;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"legend_crusader_commander_background"
		]); //skills on start
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.FortifiedMind);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendRebound);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendFavouredEnemyZombie);
		bro.m.PerkPointsSpent += 3;
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
 		bro.getSprite("socket").setBrush("bust_base_crusader"); //custom base
		bro.getSprite("miniboss").setBrush("bust_miniboss_crusader"); //custom bust
		bro.m.HireTime = this.Time.getVirtualTimeF();
		this.World.Assets.addMoralReputation(20);
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Ammo = 0;

		// this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/legend_gambeson"));
		// this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/chain/legend_armor_hauberk"));
		// this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/plate/legend_armor_plates"));
		// this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/tabard/legend_armor_tabard_10"));
	}

	function onSpawnPlayer() //spawn location
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
		this.World.Assets.updateLook(102);
		//this.World.State.m.Player.getSprite("body").setBrush("figure_player_crusader");
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_crusader_scenario_intro");
		}, null);

	}

	function onInit() //starting slots
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsCrusader", true);
	}

	function onCombatFinished() //is crusader kill?
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
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Crusader))
		{
			bro.improveMood(1.5, "Joined a righteous cause");
 			bro.getSprite("socket").setBrush("bust_base_crusader"); //custom base
		}
		else
		{
			bro.worsenMood(2.0, "Dislikes your sermons");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		this.addBroToRoster(_roster, "flagellant_background", 4);
		this.addBroToRoster(_roster, "monk_background", 4);
		this.addBroToRoster(_roster, "monk_background", 4);
		this.addBroToRoster(_roster, "witchhunter_background", 5);
		this.addBroToRoster(_roster, "legend_pilgrim_background", 4);
		this.addBroToRoster(_roster, "legend_crusader_background", 8);

		foreach( i, bro in bros )
		{

			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
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
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Crusader))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75) //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
			bro.getSkills().update();
		}
		else if (bro.getBackground().getID() == "background.squire")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.85) //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.85; //1.0 = default
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25) //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.25; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.FortifiedMind, 2, _background.isBackgroundType(this.Const.BackgroundType.Crusader));
	}


});

