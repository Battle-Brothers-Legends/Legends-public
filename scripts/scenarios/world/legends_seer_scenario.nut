this.legends_seer_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_seer";
		this.m.Name = "Seer";
		this.m.Description = "[p=c][img]gfx/ui/events/event_120.png[/img][/p][p]After studying alchemy and mystic secrets for years, you have set out to confront the evils of the world \n\n[color=#bcad8c]Bookworm:[/color] Educated people want to work for you, the uneducated find you boring to be around.\n[color=#bcad8c]Teacher[/color] Anyone you fight with gains the Student perk.\n[color=#bcad8c]Avatar:[/color] If your seer dies, the campaign ends.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 250;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}



	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"legend_witch_commander_background"
		]);
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendMagicDaze);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.Student);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendMagicMissile);
		bro.m.PerkPointsSpent += 3;

		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bro.m.HireTime = this.Time.getVirtualTimeF();

		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/black_marsh_stew_item"));
		stash.add(this.new("scripts/items/supplies/medicine_item"));
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Ammo = 0;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}

			i = ++i;
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
		this.World.Assets.updateLook(105);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_seer_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsSeer", true);
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
		this.addBroToRoster(_roster, "apprentice_background", 4);
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated))
		{
			bro.improveMood(1.0, "Excited to study from you");
		}
		else
		{
			bro.worsenMood(1.0, "Wishes you would stop using big words");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Bright))
		{
			bro.improveMood(0.5, "Keen to learn from a master");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Dumb))
		{
			bro.worsenMood(0.5, "Thinks you are a boring nerd");
		}

		bro.improveMood(0.5, "Learned a new skill");
	}


	function onGenerateBro(bro)
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated) || bro.getSkills().hasTrait(::Legends.Trait.Bright))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.9; //1.0 = default
			bro.getSkills().update();
		}
		else if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated) || bro.getSkills().hasTrait(::Legends.Trait.Dumb))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.1); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.1; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Student);
	}
});

