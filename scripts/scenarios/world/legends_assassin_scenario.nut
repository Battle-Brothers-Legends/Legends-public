this.legends_assassin_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_assassin";
		this.m.Name = "Assassin";
		this.m.Description = "[p=c][img]gfx/ui/events/event_51.png[/img][/p][p] An assassin down on their luck with limited supplies. \n\n[color=#bcad8c]Dirty Deeds:[/color] You will grant the Backstabber perk to anyone who joins you. \n[color=#bcad8c]Underworld:[/color] You have a small chance of finding other Assassins for hire. Outlaws are 50% cheaper to hire and maintain, all other backgrounds are the same cost.\n[color=#bcad8c]Avatar:[/color] Begin alone. If you die, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 20;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"legend_assassin_commander_background"
		]);
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.Backstabber);
		this.addScenarioPerk(bro.getBackground(), this.Const.Perks.PerkDefs.LoneWolf);
		bro.m.PerkPointsSpent += 2;
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true); //Avatar
 		bro.getSprite("socket").setBrush("bust_base_assassin"); //custom base
		bro.getSprite("miniboss").setBrush("bust_miniboss_assassin"); //custom bust for avatar only

		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/rice_item"));
		stash.add(this.new("scripts/items/supplies/dried_lamb_item"));
		stash.add(this.new("scripts/items/loot/signet_ring_item"));
		stash.add(this.new("scripts/items/loot/jade_broche_item"));
		stash.add(this.new("scripts/items/accessory/cat_potion_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money * 0.5;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine * 0.5;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 0.5;

	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 8), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 8));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 8), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 8));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 5)
				{
				}
				else if (!tile.HasRoad)
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
		this.World.Assets.updateLook(110);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_assassin_scenario_intro");
		}, null);

	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsAssassin", true);
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
		this.addBroToRoster(_roster, "assassin_background", 11);
		this.addBroToRoster(_roster, "assassin_southern_background", 11);
		this.addBroToRoster(_roster, "legend_bounty_hunter_background", 11); // Increased this since it is seemingly much stronger than standard assassins.
		this.addBroToRoster(_roster, "thief_background", 7);
		this.addBroToRoster(_roster, "killer_on_the_run_background", 7);
	}

	function onGenerateBro(bro)
	{
		if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw)) // if bro is NOT an outlaw then....
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.0; //1.0 = default
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.5); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.5; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onHiredByScenario( bro )
	{
		if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
		{
			bro.worsenMood(1.0, "Is uncomfortable with joining an assassin");
		}
		else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
		{
			bro.improveMood(1.0, "Is excited at becoming part of outlaw company");
 			bro.getSprite("socket").setBrush("bust_base_assassin"); //custom base
		}
	}

	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Backstabber);
	}

});

