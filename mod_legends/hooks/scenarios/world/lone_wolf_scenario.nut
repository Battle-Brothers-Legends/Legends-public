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
		this.m.BrotherScaling = 1.66;
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();

		local bro = roster.create("scripts/entity/tactical/player");
		bro.m.HireTime = this.Time.getVirtualTimeF();
		bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);

		local bros = roster.getAll(); //starting party
		bros[0].setStartValuesEx([::Legends.Background.LegendLonewolf]);
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
		this.World.Flags.set(::Legends.Camp.Flag.Training, true);
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

	o.onUpdateHiringRoster <- function ( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		local renown = this.World.Assets.getBusinessReputation();

		// Define tier thresholds of allowed backgrounds
		local tier1 = [ // >1500
			::Legends.Backgrounds.getID(::Legends.Background.Apprentice),
			::Legends.Backgrounds.getID(::Legends.Background.Beggar),
			::Legends.Backgrounds.getID(::Legends.Background.Bowyer),
			::Legends.Backgrounds.getID(::Legends.Background.Brawler),
			::Legends.Backgrounds.getID(::Legends.Background.Butcher),
			::Legends.Backgrounds.getID(::Legends.Background.Cripple),
			::Legends.Backgrounds.getID(::Legends.Background.Daytaler),
			::Legends.Backgrounds.getID(::Legends.Background.Farmhand),
			::Legends.Backgrounds.getID(::Legends.Background.Fisherman),
			::Legends.Backgrounds.getID(::Legends.Background.Flagellant),
			::Legends.Backgrounds.getID(::Legends.Background.Gambler),
			::Legends.Backgrounds.getID(::Legends.Background.Gravedigger),
			::Legends.Backgrounds.getID(::Legends.Background.Graverobber),
			::Legends.Backgrounds.getID(::Legends.Background.Lumberjack),
			::Legends.Backgrounds.getID(::Legends.Background.Miner),
			::Legends.Backgrounds.getID(::Legends.Background.Minstrel),
			::Legends.Backgrounds.getID(::Legends.Background.Monk),
			::Legends.Backgrounds.getID(::Legends.Background.Poacher),
			::Legends.Backgrounds.getID(::Legends.Background.Ratcatcher),
			::Legends.Backgrounds.getID(::Legends.Background.Refugee),
			::Legends.Backgrounds.getID(::Legends.Background.Shepherd),
			::Legends.Backgrounds.getID(::Legends.Background.Squire),
			::Legends.Backgrounds.getID(::Legends.Background.Thief),
			::Legends.Backgrounds.getID(::Legends.Background.Vagabond),
			::Legends.Backgrounds.getID(::Legends.Background.Wildman),
			::Legends.Backgrounds.getID(::Legends.Background.LegendIronmonger)
		];

		local tier2 = [ // >2000
			::Legends.Backgrounds.getID(::Legends.Background.Barbarian),
			::Legends.Backgrounds.getID(::Legends.Background.Bastard),
			::Legends.Backgrounds.getID(::Legends.Background.Cultist),
			::Legends.Backgrounds.getID(::Legends.Background.Deserter),
			::Legends.Backgrounds.getID(::Legends.Background.Houndmaster),
			::Legends.Backgrounds.getID(::Legends.Background.Hunter),
			::Legends.Backgrounds.getID(::Legends.Background.Juggler),
			::Legends.Backgrounds.getID(::Legends.Background.KillerOnTheRun),
			::Legends.Backgrounds.getID(::Legends.Background.Militia),
			::Legends.Backgrounds.getID(::Legends.Background.RetiredSoldier),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBlacksmith)
		];

		local tier3 = [ // >2650
			::Legends.Backgrounds.getID(::Legends.Background.AdventurousNoble),
			::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer),
			::Legends.Backgrounds.getID(::Legends.Background.DisownedNoble),
			::Legends.Backgrounds.getID(::Legends.Background.Raider),
			::Legends.Backgrounds.getID(::Legends.Background.Witchhunter),
			::Legends.Backgrounds.getID(::Legends.Background.LegendConscript),
			::Legends.Backgrounds.getID(::Legends.Background.LegendInventor),
			::Legends.Backgrounds.getID(::Legends.Background.LegendShieldmaiden)
		];

		local tier4 = [ // >3500
			::Legends.Backgrounds.getID(::Legends.Background.AssassinSouthern),
			::Legends.Backgrounds.getID(::Legends.Background.Gladiator),
			::Legends.Backgrounds.getID(::Legends.Background.HedgeKnight),
			::Legends.Backgrounds.getID(::Legends.Background.Sellsword),
			::Legends.Backgrounds.getID(::Legends.Background.Swordmaster),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBladedancer),
			::Legends.Backgrounds.getID(::Legends.Background.LegendMasterArcher)
		];

		local tier5 = [ // >4500
			::Legends.Backgrounds.getID(::Legends.Background.Assassin),
			::Legends.Backgrounds.getID(::Legends.Background.Paladin),
			::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker),
			::Legends.Backgrounds.getID(::Legends.Background.LegendManAtArms),
			::Legends.Backgrounds.getID(::Legends.Background.LegendNoble2h),
			::Legends.Backgrounds.getID(::Legends.Background.LegendNobleRanged),
			::Legends.Backgrounds.getID(::Legends.Background.LegendNobleShield)
		];

		// Combine tiers based on current renown
		local allowed = [];
		if (renown > 1500) allowed.extend(tier1);
		if (renown > 2000) allowed.extend(tier2);
		if (renown > 2650) allowed.extend(tier3);
		if (renown > 3500) allowed.extend(tier4);
		if (renown > 4500) allowed.extend(tier5);

		// Now process roster
		foreach (i, bro in bros)
		{
			local bgID = bro.getBackground().getID();

			// Always keep donkey
			if (bgID == ::Legends.Backgrounds.getID(::Legends.Background.LegendDonkey))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
				bro.getBaseProperties().DailyWageMult *= 1.0;
				bro.getSkills().update();
				continue;
			}

			// If not allowed by renown threshold, remove
			if (allowed.find(bgID) == null)
			{
				garbage.push(bro);
			}
		}

		// Remove unqualified hires
		foreach (g in garbage)
		{
			_roster.remove(g);
		}
	}

	o.onHiredByScenario <- function ( _bro ) //recruits via events
	{
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendLWRelationship);
	}

	// o.onGenerateBro <- function (bro) //companions free everyone else normal. //Removed 14/6/26 due to all recuits being zero. Code is unnecessary now as I have just changed all companons to 0 and now everyone else should force defult as defined by vanilla logic - Luft.
	// {
	// 	if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Companion))
	// 	{
	// 		bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.0); //1.0 = default
	// 		bro.getBaseProperties().DailyWageMult *= 0.0; //1.0 = default
	// 		bro.getSkills().update();
	// 	}
	// 	else
	// 	{
	// 		bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
	// 		bro.getBaseProperties().DailyWageMult *= 1.0;
	// 		bro.getSkills().update();
	// 	}
	// }

	o.setupBro <- function ( _bro )
	{
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendLWRelationship);
	}
});

