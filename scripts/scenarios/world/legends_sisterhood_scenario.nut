this.legends_sisterhood_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_sisterhood";
		this.m.Name = "Sisterhood";
		this.m.Description = "[p=c][img]gfx/ui/events/event_91.png[/img][/p][p]Born into a world dominated by kings and bishops, you have studied the old ways of the wise women. Now you lead a band of powerful women shaping their own destinies. \n\n[color=#bcad8c]Sisterhood:[/color] You can only hire women and each gains the Hold Out perk.\n[color=#bcad8c]Threads of fate:[/color] Your chants and trances alter the minds of your allies and enemies.\n[color=#bcad8c]Rune stones:[/color] You can craft powerful items imbued with ancient runes.\n[color=#bcad8c]Avatar:[/color] If you die, it is game over[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 260;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Unhold;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 6; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
			bro.m.PerkPointsSpent += 1;
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_shieldmaiden_background"
		], true, 1);
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[1].setStartValuesEx([
			"wildwoman_background"
		], true, 1);
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[2].setStartValuesEx([
			"female_thief_background"
		], true, 1);
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[3].setStartValuesEx([
			"female_bowyer_background"
		], true, 1);
		bros[3].setPlaceInFormation(12);
		bros[3].setVeteranPerks(2);
		bros[4].setStartValuesEx([
			"legend_vala_commander_background"
		], true, 1);
		bros[4].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
		bros[4].getFlags().set("IsPlayerCharacter", true);
		bros[4].setPlaceInFormation(13);
		bros[4].setVeteranPerks(2);
		bros[5].setStartValuesEx([
			"female_adventurous_noble_background"
		], true, 1);
		bros[5].setPlaceInFormation(14);
		bros[5].setVeteranPerks(2);
		this.World.Flags.set("HasLegendCampGathering", true);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
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
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 3), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 3), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

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
		this.World.Assets.updateLook(108);
		this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", randomVillageTile.Coords).setSize(1);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_sisterhood_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.m.RosterTier = 2;
		this.World.Flags.set("IsLegendsVala", true);
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Female))
		{
			bro.improveMood(1.0, "Joined the righteous cause of the Sisterhood");
			bro.getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
			bro.improveMood(0.5, "Learned a new skill");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.isStabled())
			{
				continue;
			}

			if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Female))
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
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

	function onUpdateDraftList( _list, _gender )
	{
		if (_list.len() >= 10)
		{
			local r;
			r = this.Math.rand(0, 9);

			if (r == 0)
			{
				_list.push("legend_shieldmaiden_background");
			}

			r = this.Math.rand(0, 9);

			if (r == 0)
			{
				_list.push("female_disowned_noble_background");
			}

			r = this.Math.rand(0, 3);

			if (r == 0)
			{
				_list.push("female_daytaler_background");
			}

			r = this.Math.rand(0, 5);

			if (r == 0)
			{
				_list.push("female_beggar_background");
			}

			r = this.Math.rand(0, 9);

			if (r == 0)
			{
				_list.push("female_bowyer_background");
			}

			r = this.Math.rand(0, 6);

			if (r == 0)
			{
				_list.push("female_butcher_background");
			}

			r = this.Math.rand(0, 4);

			if (r == 0)
			{
				_list.push("female_farmhand_background");
			}

			r = this.Math.rand(0, 7);

			if (r == 0)
			{
				_list.push("female_miller_background");
			}

			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				_list.push("female_servant_background");
			}

			r = this.Math.rand(0, 6);

			if (r == 0)
			{
				_list.push("female_tailor_background");
			}

			r = this.Math.rand(0, 8);

			if (r == 0)
			{
				_list.push("female_thief_background");
			}

			r = this.Math.rand(0, 8);

			if (r == 0)
			{
				_list.push("legend_nun_background");
			}
		}
		else
		{
			local r;
			r = this.Math.rand(0, 6);

			if (r == 0)
			{
				_list.push("female_daytaler_background");
			}

			r = this.Math.rand(0, 10);

			if (r == 0)
			{
				_list.push("female_beggar_background");
			}

			r = this.Math.rand(0, 18);

			if (r == 0)
			{
				_list.push("female_bowyer_background");
			}

			r = this.Math.rand(0, 12);

			if (r == 0)
			{
				_list.push("female_butcher_background");
			}

			r = this.Math.rand(0, 8);

			if (r == 0)
			{
				_list.push("female_farmhand_background");
			}

			r = this.Math.rand(0, 14);

			if (r == 0)
			{
				_list.push("female_miller_background");
			}

			r = this.Math.rand(0, 8);

			if (r == 0)
			{
				_list.push("female_servant_background");
			}

			r = this.Math.rand(0, 12);

			if (r == 0)
			{
				_list.push("female_tailor_background");
			}

			r = this.Math.rand(0, 16);

			if (r == 0)
			{
				_list.push("female_thief_background");
			}

			r = this.Math.rand(0, 16);

			if (r == 0)
			{
				_list.push("legend_nun_background");
			}
		}
	}

});

