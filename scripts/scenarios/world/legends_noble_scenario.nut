this.legends_noble_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_noble";
		this.m.Name = "Noble";
		this.m.Description = "[p=c][img]gfx/ui/events/event_96.png[/img][/p][p] You are a noble on the run from your house with your retainers. \n\n[color=#bcad8c]Usurper:[/color] Can unlock noble contracts from the start.\n[color=#bcad8c]Highborn:[/color] Nobles will cost 25% less, lowborns will cost 50% more, can\'t hire outlaws\n[color=#bcad8c]Trained leader:[/color] Your studies at the academy gave tactical skills, everyone begins with Rotation.\n[color=#bcad8c]Avatar:[/color] if your character dies, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 170;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(6);
		this.m.StartingBusinessReputation = 1100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{

		local roster = this.World.getPlayerRoster();
		for( local i = 0; i < 6; i = ++i )
		{
			local bro = roster.create("scripts/entity/tactical/player");
			if (i != 0)
			{
				bro.fillTalentValues(3); //quick way to skip noble commander's fill talent values
			}
		}
		local bros = roster.getAll();

		// Noble Commander Create

		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setStartValuesEx([
			"legend_noble_commander_background"
		], false);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].setPlaceInFormation(13);
		bros[0].setVeteranPerks(2);
		bros[0].getSkills().add(this.new("scripts/skills/traits/drunkard_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/legend_noble_killer_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.RallyTheTroops);

		// End Noble Commander Create
		// Noble Shield 1 Create

		bros[1].setStartValuesEx([
		"legend_noble_shield"
		], false);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local r = this.Math.rand(1, 2);
		local shield;
		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}
		items.equip(shield);

		bros[1].getBackground().m.RawDescription = "Though a lowly foot soldier %name% has one of the most upbeat outlooks on life you\'ve ever encountered. Unfortunately that extends to an over evaluation of self worth, expecting more pay than most.";
		bros[1].getBackground().buildDescription(true);
		bros[1].getSkills().add(this.new("scripts/skills/traits/optimist_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/determined_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/greedy_trait"));
		this.addScenarioPerk(bros[1].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[1].setPlaceInFormation(3);

		// End Noble Shield 1 Create
		// Noble 2h create

		bros[2].setStartValuesEx([
		"legend_noble_2h"
		], false);
		bros[2].getBackground().m.RawDescription = "%name% is a hulking figure, both upward and outward. Not much of a talker, but a big eater.";
		bros[2].getBackground().buildDescription(true);
		bros[2].getSkills().removeByID("trait.tiny");
		bros[2].getSkills().add(this.new("scripts/skills/traits/huge_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/fat_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/gluttonous_trait"));
		this.addScenarioPerk(bros[2].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[2].setPlaceInFormation(4);

		// End Noble 2h Create
		// Noble Shield 2 Create

		bros[3].setStartValuesEx([
			"legend_noble_shield"
		], false);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}
		items.equip(shield);
		bros[3].getBackground().m.RawDescription = "%name%\'s parents both served your family, it runs in the blood. While %name% is dependable in a fight and would never dream of leaving you, it also reduces their %name%\'s ambition and drive";
		bros[3].getBackground().buildDescription(true);
		bros[3].getSkills().add(this.new("scripts/skills/traits/legend_pragmatic_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/legend_slack_trait"));
		this.addScenarioPerk(bros[3].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[3].setPlaceInFormation(5);

		// End Noble Shield 2 Create
		// Noble Servant Create

		bros[4].setStartValuesEx([
		"servant_background"
		], false);
		bros[4].getBackground().m.RawDescription = "%name% has been a servant in your family for 5 generations now, it is unclear how anyone has survived this long, but there are no indications of the old coot giving up any time soon.";
		bros[4].getBackground().buildDescription(true);
		bros[4].getSkills().add(this.new("scripts/skills/traits/old_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/lucky_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/survivor_trait"));
		this.addScenarioPerk(bros[4].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[4].setPlaceInFormation(12);
		local items = bros[4].getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"]
		]));
		items.equip(this.new("scripts/items/supplies/legend_pudding_item"));
		items.addToBag(this.new("scripts/items/supplies/wine_item"));

		// End Noble Servant Create
		// Arbalester Create

		bros[5].setStartValuesEx([
		"legend_noble_ranged"
		], false);
		bros[5].getBackground().m.RawDescription = "%name% has won the house archery contest several years running, but never shuts up about it. The constant stream of narration makes the great aim easy to dodge.";
		bros[5].getBackground().buildDescription(true);
		bros[5].getSkills().add(this.new("scripts/skills/traits/legend_sureshot_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/teamplayer_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/legend_predictable_trait"));
		this.addScenarioPerk(bros[5].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		if (bros[5].getBaseProperties().RangedSkill  <= 60) {
			bros[5].getBaseProperties().RangedSkill  += 5;
		}

		bros[5].setPlaceInFormation(14);

		// End arbalester create


		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 7), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 7));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 7), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 7));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 4)
				{
				}
				else if (!tile.HasRoad || tile.Type == this.Const.World.TerrainType.Shore)
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
		this.World.Assets.updateLook(101);
		//this.World.State.m.Player.getSprite("body").setBrush("figure_player_noble");
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		local f = randomVillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		f.addPlayerRelation(-100.0, "You chose the wrong faction");
		local banner = f.getBanner();

		local brothers = this.World.getPlayerRoster().getAll();

		//1, 3 are shield brothers
		brothers[1].getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).setFaction(banner);
		brothers[3].getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).setFaction(banner);

		foreach( bro in brothers )
		{
			local items = bro.getItems();
			local armor = items.getItemAtSlot(this.Const.ItemSlot.Body);
			local tabards = [
					[0, ""],
					[1, "tabard/legend_noble_tabard"]
				];
				local tabard = this.Const.World.Common.pickLegendArmor(tabards);
				if (tabard != null && armor != null)
				{
					tabard.setVariant(banner);
					armor.setUpgrade(tabard);
				}
		}

		//noble start actually doesnt go thru the generalized place for this and i'm too lazy to change it to do so because then i'd have to redo aarmor equips because there's no banner stuff etc
		// foreach (bro in this.World.getPlayerRoster().getAll())
		// {
		// 	bro.setCompanyID(this.World.State.addNewID(bro));
		// }


		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_noble_scenario_intro");
		}, null);
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

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Flags.set("IsLegendsNoble", true);
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble))
		{
			bro.improveMood(0.5, "Supports your cause as a usurper, will cost less to maintain.");
		}
		else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn))
		{
			bro.worsenMood(0.5, "Resents you as nobility, will try to squeeze money from you.");
		}
		bro.improveMood(0.5, "Learned a new skill");
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();
		this.addBroToRoster(_roster, "legend_noble_2h", 4);
		this.addBroToRoster(_roster, "legend_noble_shield", 4);
		this.addBroToRoster(_roster, "legend_noble_ranged", 4);
		this.addBroToRoster(_roster, "adventurous_noble_background", 8);
		// this.addBroToRoster(_roster, "female_adventurous_noble_background", 6);
		this.addBroToRoster(_roster, "disowned_noble_background", 8);
		// this.addBroToRoster(_roster, "female_disowned_noble_background", 6);

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Outlaw))
			{
				garbage.push(bro);
			}
		}


		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onGenerateBro(bro)
	{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75); //1.0 = default
				bro.getBaseProperties().DailyWageMult *= 0.75; //1.0 = default
				bro.getSkills().update();
			}
			else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn))
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.5); //1.0 = default
				bro.getBaseProperties().DailyWageMult *= 1.5; //1.0 = default
				bro.getSkills().update();
			}
	}


	function onBuildPerkTree( _background )
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.Rotation);
	}
});
