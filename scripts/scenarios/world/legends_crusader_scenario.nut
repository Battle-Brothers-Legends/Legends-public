this.legends_crusader_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},

	function create() {
		this.m.ID = "scenario.legends_crusader";
		this.m.Name = "Crusader";
		this.m.Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]Sent on a holy quest to rid the world of undead, you walk a righteous path. \n\n[color=#bcad8c]Pure of Heart:[/color] You cannot recruit outlaw backgrounds, while pious recruits and squires cost less.\n[color=#bcad8c]Strict Sermons:[/color] You will grant the Fortified Mind perk to any pious background that joins you. Find Pilgrims to aid you on your journey.\n[color=#bcad8c]Avatar:[/color] If your crusader dies, the campaign ends.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 70;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(3);
		this.m.StartingBusinessReputation = 1150;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets() {
		local roster = ::World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([::Legends.Background.LegendCrusader]);
		 //skills on start
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);
		::Legends.Traits.grant(bro, ::Legends.Trait.LegendUndeadKiller);
		this.addScenarioPerk(bro.getBackground(), ::Const.Perks.PerkDefs.FortifiedMind);
		this.addScenarioPerk(bro.getBackground(), ::Const.Perks.PerkDefs.LegendRebound);
		this.addScenarioPerk(bro.getBackground(), ::Const.Perks.PerkDefs.LegendFavouredEnemyUndead);
		bro.m.PerkPointsSpent += 3;
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("socket").setBrush("bust_base_crusader"); //custom base
		bro.getSprite("miniboss").setBrush("bust_miniboss_crusader"); //custom bust
		bro.m.HireTime = ::Time.getVirtualTimeF();
		::World.Assets.addMoralReputation(20);
		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.m.Ammo = 0;

		local stash = ::World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/armor_parts_item"));
		stash.add(this.new("scripts/items/supplies/medicine_item"));
		stash.add(this.new("scripts/items/supplies/cured_venison_item"));
	}

	function onSpawnPlayer() //spawn location
	{
		local randomVillage;

		for (local i = 0; i != ::World.EntityManager.getSettlements().len(); i = ++i) {
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary()
				&& !randomVillage.isIsolatedFromRoads()
				&& randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do {
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 1), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 1), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!::World.isValidTileSquare(x, y)) {
			} else {
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean
					|| tile.Type == ::Const.World.TerrainType.Shore)
				{
				} else if (tile.getDistanceTo(randomVillageTile) == 0) {
				} else if (!tile.HasRoad) {
				} else {
					randomVillageTile = tile;
					break;
				}
			}
		} while (1);

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(102);
		//::World.State.m.Player.getSprite("body").setBrush("figure_player_crusader");
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function (_tag) {
			::Music.setTrackList([
				"music/noble_02.ogg"
			], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_crusader_scenario_intro");
		}, null);

	}

	function onInit() //starting slots
	{
		this.starting_scenario.onInit();
		::World.Flags.set("IsLegendsCrusader", true);
	}

	function onCombatFinished() //is crusader kill?
	{
		local roster = ::World.getPlayerRoster().getAll();

		foreach (bro in roster) {
			if (bro.getFlags().get("IsPlayerCharacter")) {
				return true;
			}
		}

		return false;
	}

	function onHiredByScenario(_bro) {
		if (_bro.getBackground().isBackgroundType(::Const.BackgroundType.Crusader)) {
			_bro.improveMood(1.5, "Joined a righteous cause");
			_bro.getSprite("socket").setBrush("bust_base_crusader"); //custom base
		} else {
			_bro.worsenMood(2.0, "Dislikes your sermons");
		}
	}

	function onUpdateHiringRoster(_roster) {
		local garbage = [];
		local bros = _roster.getAll();

		this.addBroToRoster(_roster, ::Legends.Background.Crusader, 8);
		this.addBroToRoster(_roster, ::Legends.Background.Flagellant, 4);
		this.addBroToRoster(_roster, ::Legends.Background.Monk, 8);
		this.addBroToRoster(_roster, ::Legends.Background.Witchhunter, 5);
		this.addBroToRoster(_roster, ::Legends.Background.LegendPilgrim, 4);

		foreach (i, bro in bros) {

			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.Outlaw)) {
				garbage.push(bro);
			}
		}

		foreach (g in garbage) {
			_roster.remove(g);
		}
	}

	function onGenerateBro(bro) {
		if (bro.isStabled())
			return;

		if (bro.getBackground().isBackgroundType(::Const.BackgroundType.Crusader)) {
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 0.75); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
			bro.getSkills().update();
		} else if (::Legends.Backgrounds.has(bro, ::Legends.Background.Squire)) {
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 0.85); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.85; //1.0 = default
			bro.getSkills().update();
		} else {
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 1.25); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.25; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onBuildPerkTree(_background) {
		this.addScenarioPerk(_background, ::Const.Perks.PerkDefs.FortifiedMind, 2, _background.isBackgroundType(::Const.BackgroundType.Crusader));
	}

});
