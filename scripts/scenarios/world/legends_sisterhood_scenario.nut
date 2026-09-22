this.legends_sisterhood_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},

	function create() {
		this.m.ID = "scenario.legends_sisterhood";
		this.m.Name = "Sisterhood";
		this.m.Description = "[p=c][img]gfx/ui/events/event_91.png[/img][/p][p]Born into a world dominated by kings and bishops, you have studied the old ways of the wise women. Now you lead a band of powerful women shaping their own destinies. \n\n[color=#bcad8c]Sisterhood:[/color] You can only hire women and each gains the [color=" + ::Const.UI.Color.Perk + "]Resillient[/color] perk.\n[color=#bcad8c]Threads of fate:[/color] Your chants and trances alter the minds of your allies and enemies.\n[color=#bcad8c]Rune stones:[/color] You can craft powerful items imbued with ancient runes.\n[color=#bcad8c]Avatar:[/color] If you die, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(6);
		this.starting_scenario.create();
	}

	function onSpawnAssets() {
		local roster = ::World.getPlayerRoster();

		for (local i = 0; i < 6; i = i) {
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = ::Time.getVirtualTimeF();
			::Legends.Perks.grant(bro, ::Legends.Perk.HoldOut);
			bro.m.PerkPointsSpent += 1;
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([::Legends.Background.LegendShieldmaiden], true, 1);
		bros[0].setPlaceInFormation(3);

		bros[1].setStartValuesEx([::Legends.Background.Wildman], true, 1);
		bros[1].setPlaceInFormation(4);

		bros[2].setStartValuesEx([::Legends.Background.LegendBattleSister], true, 1);
		bros[2].setPlaceInFormation(5);

		bros[3].setStartValuesEx([::Legends.Background.Monk], true, 1);
		bros[3].setPlaceInFormation(12);

		bros[4].setStartValuesEx([::Legends.Background.LegendVala], true, 1);
		::Legends.Traits.grant(bros[4], ::Legends.Trait.Player);
		this.addScenarioPerk(bros[4].getBackground(), ::Const.Perks.PerkDefs.LegendValaWarden);
		bros[4].m.PerkPointsSpent += 1;
		bros[4].getFlags().set("IsPlayerCharacter", true);
		bros[4].setPlaceInFormation(13);
		bros[4].setVeteranPerks(2);

		bros[5].setStartValuesEx([::Legends.Background.AdventurousNoble], true, 1);
		bros[5].setPlaceInFormation(14);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Gatherer], true);
		::World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
	}

	function onSpawnPlayer() {
		local randomVillage;

		for (local i = 0; i != ::World.EntityManager.getSettlements().len(); i = i) {
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1) {
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		do {
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 3), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 3), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

			if (!::World.isValidTileSquare(x, y)) {
			} else {
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied) {
				} else if (tile.getDistanceTo(randomVillageTile) <= 1) {
				} else {
					local path = ::World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty()) {
						randomVillageTile = tile;
						break;
					}
				}
			}
		} while (1);

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(108);
		::World.spawnLocation("scripts/entity/world/locations/battlefield_location", randomVillageTile.Coords).setSize(1);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function (_tag) {
			::Music.setTrackList(::Const.Music.CivilianTracks, ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_sisterhood_scenario_intro");
		}, null);
	}

	function onInit() {
		this.starting_scenario.onInit();
		::World.Flags.set("IsLegendsVala", true);
	}

	function onHiredByScenario(_bro) {
		if (_bro.getBackground().isBackgroundType(::Const.BackgroundType.Female)) {
			_bro.improveMood(1.0, "Joined the righteous cause of the Sisterhood");
			_bro.improveMood(0.5, "Learned a new skill");
		}
	}

	function onUpdateHiringRoster(_roster) {
		local garbage = [];
		local bros = _roster.getAll();

		this.addBroToRoster(_roster, ::Legends.Background.LegendShieldmaiden, 6);

		foreach (_, bro in bros) {
			if (bro.isStabled()) {
				continue;
			}

			if (!bro.getBackground().isBackgroundType(::Const.BackgroundType.Female)) {
				garbage.push(bro);
			}
		}
		foreach (g in garbage) {
			_roster.remove(g);
		}
	}

	function onCombatFinished() {
		local roster = ::World.getPlayerRoster().getAll();

		foreach (bro in roster) {
			if (bro.getFlags().get("IsPlayerCharacter")) {
				return true;
			}
		}

		return false;
	}

	function onBuildPerkTree(_background) {
		this.addScenarioPerk(_background, ::Const.Perks.PerkDefs.HoldOut, 0, _background.isBackgroundType(::Const.BackgroundType.Female));
	}

});
