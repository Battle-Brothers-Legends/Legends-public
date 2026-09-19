::mods_hookExactClass("scenarios/world/gladiators_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.gladiators";
		this.m.Name = "Gladiators";
		this.m.Description = "[p=c][img]gfx/ui/events/event_155.png[/img][/p][p]You\'ve fought in the arenas of the south for years. First for your freedom, then for crowns, and finally to become immortal. What else does fate have in stock for you?\n\n[color=#bcad8c]Gladiators:[/color] Start with three experienced gladiators with good equipment, but very high daily wages.\n[color=#bcad8c]Legends of the Arena:[/color] Each gladiator has a unique trait in combat.\n[color=#bcad8c]Glorious Three:[/color] You can never have more than 16 fighters in your roster, and if all of your three starting men should die, your campaign ends.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 130;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(3);
		this.m.RosterTierMax = ::Const.Roster.getTierForSize(16);
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.onSpawnAssets = function ()
	{
		local roster = ::World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx([::Legends.Background.GladiatorOrigin]);
			::Legends.Traits.remove(bro, ::Legends.Trait.Survivor);
			::Legends.Traits.remove(bro, ::Legends.Trait.Greedy);
			::Legends.Traits.remove(bro, ::Legends.Trait.Loyal);
			::Legends.Traits.remove(bro, ::Legends.Trait.Disloyal);
			::Legends.Traits.grant(bro, ::Legends.Trait.ArenaFighter);
			bro.getFlags().set("ArenaFightsWon", 5);
			bro.getFlags().set("ArenaFights", 5);
			bro.setPlaceInFormation(3 + i);
			bro.getFlags().set("IsPlayerCharacter", true);
			bro.getSprite("miniboss").setBrush("bust_miniboss_gladiators");
			bro.m.HireTime = ::Time.getVirtualTimeF();
			bro.m.PerkPoints = 2;
			bro.m.LevelUps = 2;
			bro.m.Level = 3;
			bro.m.Talents = [];
			bro.m.Attributes = [];
			bro.setVeteranPerks(2);
		}

		local bros = roster.getAll();
		local a;
		local u;
		bros[0].setTitle("the Lion");
		::Legends.Traits.grant(bros[0], ::Legends.Trait.GloriousResolve);
		bros[0].getTalents().resize(::Const.Attributes.COUNT, 0);
		bros[0].getTalents()[::Const.Attributes.MeleeDefense] = 2;
		bros[0].getTalents()[::Const.Attributes.Fatigue] = 2;
		bros[0].getTalents()[::Const.Attributes.MeleeSkill] = 3;
		bros[0].fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		a = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness],
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));

		bros[0].getItems().equip(a);
		a = ::Const.World.Common.pickHelmet([
			[1, "oriental/gladiator_helmet", 13]
		]);
		bros[0].getItems().equip(a);
		bros[0].getItems().equip(this.new("scripts/items/weapons/scimitar"));
		bros[0].getItems().equip(this.new("scripts/items/tools/throwing_net"));
		bros[0].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[0].setVeteranPerks(2);
		bros[1].setTitle("the Bear");
		::Legends.Traits.grant(bros[1], ::Legends.Trait.GloriousEndurance);
		bros[1].getTalents().resize(::Const.Attributes.COUNT, 0);
		bros[1].getTalents()[::Const.Attributes.Hitpoints] = 3;
		bros[1].getTalents()[::Const.Attributes.Fatigue] = 2;
		bros[1].getTalents()[::Const.Attributes.Bravery] = 2;
		bros[1].fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		a = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness],
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		bros[1].getItems().equip(a);
		a = ::Const.World.Common.pickHelmet([
			[1, "oriental/gladiator_helmet", 15]
		]);
		bros[1].getItems().equip(a);
		bros[1].getItems().equip(this.new("scripts/items/weapons/oriental/heavy_southern_mace"));
		bros[1].getItems().equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
		bros[1].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[1].setVeteranPerks(2);
		bros[2].setTitle("the Viper");
		::Legends.Traits.grant(bros[2], ::Legends.Trait.GloriousQuickness);
		bros[2].getTalents().resize(::Const.Attributes.COUNT, 0);
		bros[2].getTalents()[::Const.Attributes.MeleeDefense] = 2;
		bros[2].getTalents()[::Const.Attributes.Initiative] = 3;
		bros[2].getTalents()[::Const.Attributes.MeleeSkill] = 2;
		bros[2].fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		a = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness],
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		bros[2].getItems().equip(a);
		a = ::Const.World.Common.pickHelmet([
			[1, "oriental/gladiator_helmet", 14]
		]);
		bros[2].getItems().equip(a);
		bros[2].getItems().equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		bros[2].getItems().equip(this.new("scripts/items/tools/throwing_net"));
		bros[2].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[2].setVeteranPerks(2);
		bros[0].getBackground().m.RawDescription = "{%fullname% thinks muscles make for glory. Wrong. Captain, it is I, " + bros[2].getName() + ", who commands the ladies of this realm. Need not ask me how. Behold! Look at it! Look at the size of it! Yeah. That\'s what I thought. Fools, train all you want, you can\'t have this!}";
		bros[0].getBackground().buildDescription(true);
		bros[1].getBackground().m.RawDescription = "{%fullname% is not the best warrior here, let\'s be clear. Captain, look at my muscles, is it not I, " + bros[0].getName() + ", who commands the greatest reward of life: the fear of one\'s own enemies! Look, if I lather a little and catch the light, the muscles gleam. Would it not be that the heavens were mistakened for above, when all the women say they find them right here, particularly here, upon my glorious pecs?}";
		bros[1].getBackground().buildDescription(true);
		bros[2].getBackground().m.RawDescription = "{Why are you looking at %fullname%? Captain, it is I, " + bros[1].getName() + ", who is your greatest gladiator. I am the one who swept the legs of a lindwurm and choked it out with its own tail! What you bastards say? You call that a tall tale? Pah! \'Tis a horizontal lizard at best.}";
		bros[2].getBackground().buildDescription(true);

		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.getStash().resize(::World.Assets.getStash().getCapacity() - 9);
		::World.Assets.getStash().add(this.new("scripts/items/supplies/dried_lamb_item"));
		::World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		::World.Assets.m.Money = ::World.Assets.m.Money / 2 + ::Legends.Difficulty.GladiatorsStartingMoney[::World.Assets.getEconomicDifficulty()];
		::World.Assets.m.ArmorParts = ::World.Assets.m.ArmorParts / 2;
		::World.Assets.m.Medicine = ::World.Assets.m.Medicine / 2;
		::World.Assets.m.Ammo = 0;
	}

	o.onSpawnPlayer = function ()
	{
		local randomVillage;

		for( local i = 0; i != ::World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern() && randomVillage.hasBuilding("building.arena"))
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 1), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 1), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!::World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore)
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

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(16);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.gladiators_scenario_intro");
		}, null);
	}

	o.onInit = function ()
	{
		this.starting_scenario.onInit();
	}

	o.onCombatFinished <- function ()
	{
		local roster = ::World.getPlayerRoster().getAll();
		local gladiators = 0;

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				gladiators = ++gladiators;
			}
		}

		if (gladiators == 2 && !::World.Flags.get("GladiatorsOriginDeath2"))
		{
			::World.Flags.set("GladiatorsOriginDeath2", true);

			foreach( bro in roster )
			{
				if (bro.getFlags().get("IsPlayerCharacter"))
				{
					bro.getBackground().m.RawDescription = "{%fullname% is somber about the passing of a good friend, but he looks to the future knowing that he has someone behind him at all times. Behind him in a brotherly way, that is. And spiritually. Brotherly and spiritually, only.}";
					bro.getBackground().buildDescription(true);
				}
			}
		}
		else if (gladiators == 1 && !::World.Flags.get("GladiatorsOriginDeath1"))
		{
			::World.Flags.set("GladiatorsOriginDeath1", true);

			foreach( bro in roster )
			{
				if (bro.getFlags().get("IsPlayerCharacter"))
				{
					bro.getBackground().m.RawDescription = "{You should know something, captain. I\'m glad you stay out of the fray. I haven\'t felt this alive in what must be ten years. And if you see me out there about to go down, you stay right where you are, because I\'ll be right where I want to be.}";
					bro.getBackground().buildDescription(true);
				}
			}
		}

		return gladiators != 0;
	}

});

