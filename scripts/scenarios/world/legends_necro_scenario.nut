this.legends_necro_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_necro";
		this.m.Name = "The Cabal";
		this.m.Description = "[p=c][img]gfx/ui/events/event_29.png[/img][/p][p] Death is no barrier, others flee from its yawning abyss, but we embrace the other side. \n\n[color=#bcad8c]Dark Arts:[/color] Start with three apprentice necromancers, each with their own strengths and weaknesses. Killed fighters in your employ have a chance to survive as undead.\n[color=#bcad8c]Blood magic:[/color] Cultists, gravediggers and similar  backgrounds will cost 25% less to maintain and gain +10 melee skill. Gravediggers and graverobbers will aid you more in gathering corpses. Cannot hire pious backgrounds. Everyone else costs 20% more to upkeep.\n[color=#bcad8c]Avatars:[/color] If all three necromancers die, the spell is broken and the story ends.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 310;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(4);
		this.m.RosterTierMax = ::Const.Roster.getTierForSize(27);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{
		local roster = ::World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 4; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
 			bro.getSprite("socket").setBrush("bust_base_undead"); //base bust for starters
			bro.m.HireTime = ::Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([::Legends.Background.LegendPreserver]); //light and fast healer
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_undead");
		bros[0].getFlags().set("IsPlayerCharacter", true); //player character
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
		bros[0].getItems().setUnlockedBagSlots(4);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendDeathlySpectre);

		bros[1].setStartValuesEx([::Legends.Background.LegendWarlockSummoner]); //sickly but good def. summons.
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].getSprite("miniboss").setBrush("bust_miniboss_undead");
		::Legends.Traits.grant(bros[1], ::Legends.Trait.Ailing);
		bros[1].getFlags().set("IsPlayerCharacter", true); //player character
		::Legends.Traits.grant(bros[1], ::Legends.Trait.Player);
		::Legends.Perks.grant(bros[1], ::Legends.Perk.NineLives);
		::Legends.Traits.grant(bros[1], ::Legends.Trait.LegendDeathlySpectre);

		bros[2].setStartValuesEx([::Legends.Background.LegendPuppetMaster]); //strong but slow tank
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].getSprite("miniboss").setBrush("bust_miniboss_undead");
		bros[2].getFlags().set("IsPlayerCharacter", true); //player character
		::Legends.Traits.grant(bros[2], ::Legends.Trait.Player);
		::Legends.Perks.grant(bros[2], ::Legends.Perk.LegendPossession);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.LegendDeathlySpectre);

		bros[3].setStartValuesEx([::Legends.Background.LegendPuppet]); //poor fucking infantry (tm)
		bros[3].getBackground().m.RawDescription = "Once a proud necromancer, %name% took three pupils under their wing to train the next generation of great necromancers. What %name% did not seeing coming is a heart attack - one that left them like a corpse like they used to command. With this macabre irony in mind, they now serve their students in unlife as little more than fodder.";
		bros[3].setPlaceInFormation(12);
		bros[3].setVeteranPerks(2);
		bros[3].m.PerkPoints = 1;
		bros[3].m.LevelUps = 1;
		bros[3].m.Level = 2;
		::Legends.Perks.grant(bros[3], ::Legends.Perk.LegendZombieBite);

		//Starting stash
		::World.Assets.m.Money = ::World.Assets.m.Money / 1;
		::World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/black_marsh_stew_item"));
		::World.Flags.set("IsLegendNecroOrigin", true);
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
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

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

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied)
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
		::World.Assets.updateLook(104);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			::Music.setTrackList(::Const.Music.CivilianTracks, ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_necro_intro_event"); //starting event
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		::World.Flags.set("IsLegendsNecro", true);
	}

	function onCombatFinished() //trio avatar checks
	{
		local roster = ::World.getPlayerRoster().getAll();
		local necros = 0;

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				necros = ++necros;
			}
		}

		if (necros == 2 && !::World.Flags.get("NecrosOriginDeath2"))
		{
			::World.Flags.set("NecrosOriginDeath2", true);

			foreach( bro in roster )
			{
				if (bro.getFlags().get("IsPlayerCharacter"))
				{
					bro.getBackground().m.RawDescription = "{While a death like any other, %name% cannot help but feel a greater sense of loss at their fallen friend - should we raise them like we do everyone else? How are we supposed to know? One thing is for sure, this time it feels differant... }";
					bro.getBackground().buildDescription(true);
				}
			}
		}
		else if (necros == 1 && !::World.Flags.get("NecrosOriginDeath1"))
		{
			::World.Flags.set("NecrosOriginDeath1", true);

			foreach( bro in roster )
			{
				if (bro.getFlags().get("IsPlayerCharacter"))
				{
					bro.getBackground().m.RawDescription = "{And then there was one, alone and adrift in a merciless world. %name% mourns the passing of their two closest friends. Maybe they weren\'t cut out for this...maybe none of them were? What if this is just one giant mistake?}";
					bro.getBackground().buildDescription(true);
				}
			}
		}

		return necros != 0;
	}


	function onHiredByScenario(_bro) {
		if (::Legends.Backgrounds.hasAny(_bro,
			::Legends.Background.Graverobber,
			::Legends.Background.Gravedigger,
			::Legends.Background.Cultist,
			::Legends.Background.ConvertedCultist
		)) {
			_bro.improveMood(1.5, "These people really understand me!");
			_bro.getSprite("socket").setBrush("bust_base_undead");
			::Legends.Traits.grant(_bro, ::Legends.Trait.LegendDeathlySpectre);
		} else if (::Legends.Backgrounds.has(_bro, ::Legends.Background.LegendPuppet)) {
			_bro.getSprite("socket").setBrush("bust_base_undead");
		} else if (!_bro.isStabled()) {
			::Legends.Traits.grant(_bro, ::Legends.Trait.LegendDeathlySpectre);
			_bro.worsenMood(2.0, "Something doesn't feel right here...");
		}
	}

	function onUpdateHiringRoster(_roster) {
		local garbage = [];
		local bros = _roster.getAll();
		this.addBroToRoster(_roster, ::Legends.Background.Cultist, 4);
		this.addBroToRoster(_roster, ::Legends.Background.Gravedigger, 4);
		this.addBroToRoster(_roster, ::Legends.Background.Graverobber, 4);
		foreach (i, bro in bros) {
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.Crusader))
			//delete crusader/pious recruits
				garbage.push(bro);
		}
		foreach (g in garbage) _roster.remove(g);
	}

	function onGenerateBro(bro)
	{
		if (bro.isStabled()) {
			return;
		}
		if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Graverobber) || bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Gravedigger) || bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Cultist))
		{
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 0.75); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
			bro.getBaseProperties().MeleeSkill += 10;
			bro.getSkills().update();
		}
		else
		{
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 1.2); //1.0 = default
			bro.getBaseProperties().DailyWageMult *= 1.2; //1.0 = default
			bro.getSkills().update();
		}
	}

	function onGetBackgroundTooltip( _background, _tooltip )
	{
		if (_background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Cultist) || _background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist) || _background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Gravedigger) || _background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Graverobber))
		{
			//_tooltip.pop();
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+10[/color] Melee Skill from being in a necromancer\'s employ"
			});
		}
	}

	// function isCultist( _background )
	// {
	// 	return _background.isBackgroundType(::Const.BackgroundType.ConvertedCultist | ::Const.BackgroundType.Cultist);
	// }
	//new end

	function onBuildPerkTree( _background )
	{
		if (_background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Gravedigger) || _background.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Graverobber))
		{
			this.addScenarioPerk(_background, ::Const.Perks.PerkDefs.LegendResurrectionist);
		}
	}
});

