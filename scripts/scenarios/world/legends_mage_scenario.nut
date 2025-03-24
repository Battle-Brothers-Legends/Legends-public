this.legends_mage_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.mage_legends_mage";
		this.m.Name = "Mage";
		this.m.Description = "[p=c][img]gfx/ui/events/event_120.png[/img][/p][p]You have always been different from those around you. By training your spirit, you discovered that you could concentrate the magic that normally only exists as a whisper in the background. Bring together those who would support you and make good use of your power.\n\n[color=#bcad8c]Sage:[/color] Educated people want to work for you, the uneducated fear you.\n[color=#bcad8c]Teacher[/color] Anyone you fight with gains the Student perk.\n[color=#bcad8c]Avatar:[/color] If your mage dies, the campaign ends.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 160;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function isValid()
	{
		return false;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"mage_legend_mage_commander_background"
		]);
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.Student);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendMindOverBody);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LegendMagicMissile);
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bro.m.HireTime = this.Time.getVirtualTimeF();
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Ammo = 0;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
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
			i = i;
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X, 1), this.Math.min(this.Const.World.Settings.SizeX, 2, randomVillageTile.SquareCoords.X + 1));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y, 1), this.Math.min(this.Const.World.Settings.SizeY, 2, randomVillageTile.SquareCoords.Y + 1));

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
			bro.improveMood(1.0, "Excited to study under you");
		}
		else
		{
			bro.worsenMood(1.0, "Scared of your magic");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Bright))
		{
			bro.improveMood(0.5, "Keen to learn from a master");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Dumb))
		{
			bro.worsenMood(0.5, "Thinks you are a boring nerd");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.LegendPragmatic))
		{
			bro.improveMood(0.5, "Thinks magic is pretty useful");
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Superstitious))
		{
			bro.worsenMood(0.5, "Thinks your magic will bring them ruin");
		}

		bro.improveMood(0.5, "Learned a new skill");
	}


	function onGenerateBro(bro)
	{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated) || bro.getSkills().hasTrait(::Legends.Trait.Bright) || bro.getSkills().hasTrait(::Legends.Trait.LegendPragmatic))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.8);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.8);
			}
			else if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated) || bro.getSkills().hasTrait(::Legends.Trait.Dumb) || bro.getSkills().hasTrait(::Legends.Trait.Superstitious))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.3);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.3);
			}
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Student);
	}
});

