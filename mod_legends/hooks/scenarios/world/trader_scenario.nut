::mods_hookExactClass("scenarios/world/trader_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.trader";
		this.m.Name = "Trading Caravan";
		this.m.Description = "[p=c][img]gfx/ui/events/event_41.png[/img][/p]You are running a small trading caravan and have most of your crowns invested into trading goods. But the roads have become dangerous - brigands and greenskins lay in ambush, and there are rumors of even worse things out there.\n\n [color=#bcad8c]Not a Warrior:[/color] Start with no renown, every non-combat recruit gains the Peaceable perk. Professional soldiers will cost 25% more and have a high chance of having additional bad traits and be less eager to stick around if things get tough. Cannot recruit outlaws.\n [color=#bcad8c]Avatar:[/color] Start with a cunning and wealthy merchant, the caravan will be dissolved if they die.\n [color=#bcad8c]Bribery:[/color] Pay off human enemies instead of fighting them. Peddlers cost 25% less.\n\n";
		this.m.Difficulty = 1;
		this.m.Order = 300;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(6);
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 2; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.worsenMood(0.5, "Encountered another caravan slaughtered by greenskins");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_peddler_commander_background"//avatar
		]);
		bros[0].setPlaceInFormation(4);
		bros[0].setVeteranPerks(2);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].getSprite("socket").setBrush("bust_base_caravan");
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_trader");
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendPeaceful);
		bros[0].m.PerkPointsSpent += 1;

		bros[1].setStartValuesEx([
			"caravan_hand_background",
			"caravan_hand_southern_background"
		]);
		bros[1].setPlaceInFormation(5);
		bros[1].getSprite("socket").setBrush("bust_base_caravan");
		bros[1].getBackground().m.RawDescription = "You found %name% being thrown out of a pub and at first glance thought that was little more than a drunken miscreant. But you watched as off three would-be muggers were soon on the ground. They still managed to take off with a coin purse in the end, sure, but they could not truly defeat %name%. Impressed, you took the newly-impoverished fighter on as a caravan hand.";
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Hitpoints] = 1;

		//starting stash
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/amber_shards_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/cloth_rolls_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/dies_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/salt_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
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
		this.World.Assets.updateLook(9);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_trader_scenario_intro");
		}, null);
	}

	o.onInit = function ()
	{
		this.starting_scenario.onInit();
		// this.World.Assets.m.BusinessReputationRate = 0.5;
		// this.World.Assets.m.BuyPriceMult = 0.9;
		// this.World.Assets.m.SellPriceMult = 1.1;
		this.World.Flags.set("IsLegendsTrader", true);
	}

	o.onCombatFinished <- function () //is kill?
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

	o.onHiredByScenario <- function ( bro )
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
		{
			bro.worsenMood(1.0, "Unhappy they will need to do all the fighting");
		}
		else if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat)) //anyone but combat background
		{
			bro.improveMood(0.5, "Glad to be out of the fighting line");
			bro.getSprite("socket").setBrush("bust_base_caravan");
		}
	}

	o.onUpdateHiringRoster <- function ( _roster )
	{
		local bros = _roster.getAll();
		local garbage = [];
		foreach( i, bro in bros )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw)) //no outlaws
			{
				garbage.push(bro);
			}
		}

		this.addBroToRoster(_roster, "peddler_background", 2);
		this.addBroToRoster(_roster, "caravan_hand_background", 3);
		this.addBroToRoster(_roster, "sellsword_background", 7);
		this.addBroToRoster(_roster, "hedge_knight_background", 7);

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	o.onGenerateBro <- function (bro)
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25);
				bro.getBaseProperties().DailyWageMult *= 1.25;
				bro.getSkills().update();
				local r;
				r = this.Math.rand(0, 5); //randomly assigned mald generator (TM)

				if (r == 0)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.Disloyal);
				}

				if (r == 1)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.Greedy);
				}

				if (r == 2)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.Weasel);
				}

				if (r == 3)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.LegendSlack);
				}

				if (r == 4)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.LegendDoubleTongued);
				}

				if (r == 5)
				{
					::Legends.Traits.grant(bro, ::Legends.Trait.Dastard);
				}
			}

			if (bro.getBackground().getID() == "background.peddler" || bro.getBackground().getID() == "background.legend_donkey")
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
				bro.getBaseProperties().DailyWageMult *= 1.25;
				bro.getSkills().update();
			}
	}


	o.onBuildPerkTree <- function ( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.LegendPeaceful, 0, !_background.isBackgroundType(this.Const.BackgroundType.Combat));
	}
});

