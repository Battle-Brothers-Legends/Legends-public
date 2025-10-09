this.legends_free_company_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_free_company";
		this.m.Name = "The Free Company";
		this.m.Description = "[p=c][img]gfx/ui/events/event_65.png[/img][/p][p]No desperate circumstances or fates to be rewritten. Take control of a successful mercenary company on the brink of becoming famous. \n[color=#bcad8c]Professional Army:[/color] Start with a roster of 5 experienced fighters in a well rounded company.\n[color=#bcad8c]Almost famous:[/color] Start with a larger roster size and professional renown.\n[color=#bcad8c]Soldiers of fortune:[/color] Can recruit everyone except unique backgrounds from other origins. No effect on trade, recruiting or upkeep.\n[color=#bcad8c]Recommended for newer players fresh from vanilla or who want a jump start.[/color][/p]";
		this.m.Difficulty = 1;
		this.m.Order = 3;
		// this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(12);
		// this.m.RosterTierMax = this.Const.Roster.getTierForSize(22);
		this.m.StartingBusinessReputation = 1150;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 5; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll(); //composed of: 2 combat wildcards | 1 elite | 1 ranged | 1 non combat background

		bros[0].setPlaceInFormation(2);
		bros[0].setVeteranPerks(2);
		bros[0].setStartValuesEx([ //wildcard 1 all possible wildcards
			"disowned_noble_background",
			"nomad_background",
			"adventurous_noble_background",
			"retired_soldier_background",
			"sellsword_background",
			"militia_background",
			"legend_conscript_background",
			"bastard_background",
			"beast_hunter_background",
			"legend_noble_ranged",
			"legend_noble_shield",
			"raider_background"
		]);

		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[1].setStartValuesEx([ //wildcard 2 all possible wildcards minus noble ranged
			"disowned_noble_background",
			"nomad_background",
			"adventurous_noble_background",
			"retired_soldier_background",
			"sellsword_background",
			"militia_background",
			"legend_conscript_background",
			"bastard_background",
			"beast_hunter_background",
			"legend_noble_shield",
			"raider_background"
		]);

		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		bros[2].setStartValuesEx([ ///elite
			"swordmaster_background",
			"legend_master_archer_background",
			"hedge_knight_background",
			"legend_noble_2h",
			"gladiator_background",
			"assassin_southern_background"
		]);

		bros[3].setPlaceInFormation(11);
		bros[3].setVeteranPerks(2);
		bros[3].setStartValuesEx([ //ranged 1
			"nomad_ranged_background",
			"hunter_background",
			"beast_hunter_background",
			"poacher_background",
			"legend_noble_ranged",
			"legend_conscript_ranged_background"
		]);

		bros[4].setPlaceInFormation(12);
		bros[4].setVeteranPerks(2);
		bros[4].setStartValuesEx([ //non combat 1
			"monk_background",
			"bowyer_background",
			"butcher_background",
			"minstrel_background",
			"servant_background",
			"legend_herbalist_background",
			"peddler_background",
			"legend_ironmonger_background",
			"tailor_background",
			"juggler_background",
			"juggler_southern_background",
			"caravan_hand_background",
			"caravan_hand_southern_background",
			"houndmaster_background"
		]);

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_fish_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/goat_cheese_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		// this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 5);
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts * 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine * 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 2;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() == 1)
			{
				break;
			}
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
		// this.World.Assets.updateLook(8);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		// randomVillage.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(25.0, "Just completed a contract for this village");
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legends_free_company_scenario_intro");
		}, null);
	}

	function onHiredByScenario( bro )
	{
	}

	function onUpdateHiringRoster( _roster )
	{
	}
});

