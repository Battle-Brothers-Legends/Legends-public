::mods_hookExactClass("scenarios/world/lone_wolf_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.lone_wolf";
		this.m.Name = "Lone Wolf";
		this.m.Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]You have been traveling for a long time, taking part in tourneys and sparring with young nobles. A hedge knight as tall as a tree, you never needed anybody for long. Is it true still?\n\n[color=#bcad8c]Lone Wolf:[/color] Start with a single experienced hedge knight with great equipment but low funds. All encounters are two-thirds harder than normal.\n[color=#bcad8c]Elite Few:[/color] Can never have more than 12 fighters in your roster. You may encounter other champions and special allies through events to join your cause.\n[color=#bcad8c]Avatar:[/color] If your lone wolf dies, the campaign ends.\n[color=#c90000]Living Legend:[/color] As your renown grows, the more recruits will be present in towns. Higher renown increases quality of hires, but you will start with being unable to hire anyone.[/p]";
		this.m.Difficulty = 4;
		this.m.Order = 150;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(1);
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(12);
		this.m.StartingBusinessReputation = 1250;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();

		local bro = roster.create("scripts/entity/tactical/player");
		bro.m.HireTime = this.Time.getVirtualTimeF();
		bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);

		local bros = roster.getAll(); //starting party
		bros[0].setStartValuesEx([
			"legend_lonewolf_background"
		]);
		bros[0].getBackground().buildDescription(true);
		bros[0].setTitle("the Lone Wolf");
		::Legends.Perks.grant(bros[0], ::Legends.Perk.LegendFavouredEnemySwordmaster);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendLWRelationship);
		bros[0].setPlaceInFormation(4);
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bros[0].m.HireTime = this.Time.getVirtualTimeF();
		bros[0].m.PerkPoints = 3;
		bros[0].m.LevelUps = 3;
		bros[0].m.Level = 4;
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		bros[0].m.Attributes = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Fatigue] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.RangedSkill] = 2;
		bros[0].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		//---
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Flags.set("HasLegendCampTraining", true);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 3 - (this.World.Assets.getEconomicDifficulty() == 0 ? 0 : 100);
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 3;
		this.World.Assets.m.Ammo = 0;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
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
		this.World.Assets.updateLook(6);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.lone_wolf_scenario_intro");
		}, null);
	}

	o.onInit = function ()
	{
		this.starting_scenario.onInit();
	}

	o.onCombatFinished <- function ()
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

	o.onUpdateHiringRoster <- function ( _roster ) //dump all hires to start, except donkey
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().getID() != "background.legend_donkey")
			{
				garbage.push(bro);
			}
	        else if (bro.getSkills().hasSkill("background.legend_donkey"))
	        {
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0); //1.0 = default
				bro.getBaseProperties().DailyWageMult *= 1.0; //1.0 = default
				bro.getSkills().update();
	        }
			else
			{
				this.setupBro(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	o.onUpdateDraftList <- function ( _draftList ) //insert specfic backgrounds at x renown level(s). *most* crafting/support backgrounds ahve been removed from this master list - companions from events cover any gaps re: retinue/camp tasks.
	{
		if (this.World.Assets.getBusinessReputation() > 750) { //peasant/lowborn + Squires
			_draftList.push("brawler_background");
			_draftList.push("squire_background");
			_draftList.push("butcher_background");
			// _draftList.push("caravan_hand_background");
			_draftList.push("cripple_background");
			_draftList.push("daytaler_background");
			// _draftList.push("miller_background");
			_draftList.push("miner_background");
			_draftList.push("minstrel_background");
			// _draftList.push("monk_background");
			// _draftList.push("peddler_background");
			_draftList.push("poacher_background");
			_draftList.push("legend_ironmonger_background");
			_draftList.push("wildman_background");
			_draftList.push("lumberjack_background");
			// _draftList.push("mason_background");
			_draftList.push("apprentice_background");
			// _draftList.push("messenger_background");
			// _draftList.push("eunuch_background");
			_draftList.push("farmhand_background");
			_draftList.push("thief_background");
			_draftList.push("fisherman_background");
			_draftList.push("flagellant_background");
			_draftList.push("gambler_background");
			_draftList.push("gravedigger_background");
			_draftList.push("graverobber_background");
			_draftList.push("beggar_background");
			// _draftList.push("historian_background");
			_draftList.push("ratcatcher_background");
			_draftList.push("refugee_background");
			// _draftList.push("servant_background");
			_draftList.push("shepherd_background");
			_draftList.push("bowyer_background");
			// _draftList.push("tailor_background");
			_draftList.push("vagabond_background");
			// _draftList.push("legend_herbalist_background");
		}

		if (this.World.Assets.getBusinessReputation() > 1500) { //basic fighters
			_draftList.push("militia_background");
			_draftList.push("deserter_background");
			_draftList.push("retired_soldier_background");
			_draftList.push("cultist_background");
			_draftList.push("houndmaster_background");
			_draftList.push("hunter_background");
			_draftList.push("juggler_background");
			_draftList.push("killer_on_the_run_background");
			// _draftList.push("taxidermist_background");
			_draftList.push("juggler_background");
			_draftList.push("barbarian_background");
			_draftList.push("bastard_background");
			_draftList.push("legend_blacksmith_background");
		}

		if (this.World.Assets.getBusinessReputation() > 2500) { //high tier
			_draftList.push("adventurous_noble_background");
			_draftList.push("disowned_noble_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("witchhunter_background");
			_draftList.push("legend_shieldmaiden_background");
			_draftList.push("raider_background");
		}

		if (this.World.Assets.getBusinessReputation() > 3500) { //elite
			_draftList.push("hedge_knight_background");
			_draftList.push("sellsword_background");
			_draftList.push("swordmaster_background");
			_draftList.push("legend_bladedancer_background");
			_draftList.push("legend_master_archer_background");
			_draftList.push("assassin_southern_background");
			_draftList.push("gladiator_background");
		}

		if (this.World.Assets.getBusinessReputation() > 4500) { //special
			_draftList.push("legend_noble_2h");
			_draftList.push("legend_noble_shield");
			_draftList.push("legend_noble_ranged");
			_draftList.push("assassin_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_conscript_background");
			_draftList.push("paladin_background");
			_draftList.push("legend_inventor_background");
			_draftList.push("legend_berserker_background");
		}
	}

	o.onHiredByScenario <- function ( _bro ) //recruits via events
	{
		this.setupBro(_bro);
	}

	o.setupBro <- function ( _bro )
	{
		_bro.m.HiringCost = 0;
		_bro.getBaseProperties().DailyWage = 0;
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendLWRelationship);
	}
});

