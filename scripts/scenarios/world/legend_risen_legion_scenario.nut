this.legend_risen_legion_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legend_risen_legion";
		this.m.Name = "Risen Legion";
		this.m.Description = "[p=c][img]gfx/ui/events/event_73.png[/img][/p]An ancient legion risen from the dead with orders to reclaim the world.\n\n[color=#bcad8c]Dreaded:[/color] All towns will begin and stay hostile to you.\n[color=#bcad8c]Fighting Legion:[/color] Higher than average marching speed across difficult terrain, begin with 8 fighters and field up to 25.\n[color=#bcad8c]Dead Walking:[/color] You cannot hire in towns, but you may find recruits by patrolling near Mass graves, Sunken Castles and The Monolith. Ancient dead are allied to you.\n";
		this.m.Difficulty = 4;
		this.m.Order = 140;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(27);
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(27);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.m.ExcludedAmbitions = [
			"ambition.allied_civilians",
			"ambition.allied_nobles",
			"ambition.defeat_civilwar",
			"ambition.defeat_holywar",
			"ambition.defeat_undead",
			"ambition.defeat_undead_location",
			"ambition.fulfill_x_southern_contracts",
			"ambition.have_all_provisions", // extremely hard to do
			"ambition.legend_have_all_camp_activities",
			"ambition.make_nobles_aware",
			"ambition.trade",
			"ambition.visit_settlements",
			"ambition.win_x_arena_fights"
		];
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for(local i = 0; i < 8; i++) {
			local bro = roster.create("scripts/entity/tactical/player");
			 ::Legends.Traits.grant(bro, ::Legends.Trait.LegendFleshless);
			bro.setVeteranPerks(3);
			bro.getSprite("socket").setBrush("bust_base_undead");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null) {
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}
			names.push(bro.getNameOnly());
		}
		local bros = roster.getAll(); //this will please the romeaboos
		//8 to start - 4 slaves, 2 aux, 2 legionaries

		//*** 1
		//*** 2
		//* * 3

		bros[0].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[0].setPlaceInFormation(3);
		local items = bros[0].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[1].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[1].setPlaceInFormation(4);
		local items = bros[1].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[2].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[2].setPlaceInFormation(5);
		local items = bros[2].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[3].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[3].setPlaceInFormation(12);
		local items = bros[3].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[4].setStartValuesEx([
			"legend_legion_auxiliary_background"
		]);
		bros[4].setPlaceInFormation(13);
		local items = bros[4].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[5].setStartValuesEx([
			"legend_legion_auxiliary_background"
		]);
		bros[5].setPlaceInFormation(14);
		local items = bros[5].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[6].setStartValuesEx([
			"legend_legion_legionary_background"
		]);
		bros[6].setPlaceInFormation(21);
		local items = bros[6].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));

		bros[7].setStartValuesEx([
			"legend_legion_legionary_background"
		]);
		bros[7].setPlaceInFormation(23);
		local items = bros[7].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));


		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);

	}

	function onSpawnPlayer()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = nearestVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(nearestVillage.getTile()) < dist)
			{
				dist = a.getTile().getDistanceTo(nearestVillage.getTile());
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement); //pes. factions

		foreach( n in settlement )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( n in oriental )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local skellies = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

		foreach( n in skellies )
		{
			n.addPlayerRelation(400.0, "For the empire!");
		}

		this.m.StaticRelationsToFaction[this.Const.FactionType.Settlement] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.NobleHouse] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.OrientalCityState] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.Undead] = true;
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", nearestVillage.getTile().Coords.X, nearestVillage.getTile().Coords.Y);
		this.World.Assets.updateLook(112);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/undead_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_risen_legion_intro");
		}, null);
		this.World.Flags.set("HasLegendCampGathering", false);
		this.World.Flags.set("HasLegendCampCrafting", false);
		this.World.Flags.set("HasLegendCampFletching", false);
		this.World.Flags.set("HasLegendCampHealing", false);
		this.World.Flags.set("HasLegendCampHunting", false);
		this.World.Flags.set("HasLegendCampScouting", false);
		this.World.Flags.set("HasLegendCampScraping", false);
		this.World.Flags.set("HasLegendCampTraining", false);
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

			if (!bro.isStabled())
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onHiredByScenario( bro )
	{
		if (!bro.getSkills().hasTrait(::Legends.Trait.RacialSkeleton) && bro.getFlags().has("skeleton"))
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.RacialSkeleton);
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendFleshless);
		}
	}

});

