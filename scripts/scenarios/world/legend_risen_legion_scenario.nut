this.legend_risen_legion_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},

	function create() {
		this.m.ID = "scenario.legend_risen_legion";
		this.m.Name = "Risen Legion";
		this.m.Description = "[p=c][img]gfx/ui/events/event_73.png[/img][/p]An ancient legion risen from the dead with orders to reclaim the world.\n\n[color=#bcad8c]Dreaded:[/color] All towns will begin and stay hostile to you.\n[color=#bcad8c]Fighting Legion:[/color] Higher than average marching speed across difficult terrain, begin with 8 fighters and field up to 25.\n[color=#bcad8c]Dead Walking:[/color] You cannot hire in towns, but you may find recruits by patrolling near Mass graves, Sunken Castles and The Monolith. Ancient dead are allied to you.\n";
		this.m.Difficulty = 4;
		this.m.Order = 140;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(27);
		this.m.RosterTierMax = ::Const.Roster.getTierForSize(27);
	}

	function onInit() {
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
			"ambition.win_x_arena_fights",
			"ambition.legend_allied_city_states"
		];
	}

	function onSpawnAssets() {
		local roster = ::World.getPlayerRoster();
		local names = [];

		for (local i = 0; i < 8; i++) {
			local bro = roster.create("scripts/entity/tactical/legend_player_legion");
			bro.setVeteranPerks(3);
			bro.getSprite("socket").setBrush("bust_base_undead");
			bro.m.HireTime = ::Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null) {
				bro.setName(::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]);
			}
			names.push(bro.getNameOnly());
		}
		local bros = roster.getAll(); //this will please the romeaboos
		//8 to start - 4 slaves, 2 aux, 2 legionaries

		//*** 1
		//*** 2
		//* * 3

		bros[0].setStartValuesEx([::Legends.Background.LegendLegionSlave]);
		bros[0].setPlaceInFormation(3);
		local items = bros[0].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[1].setStartValuesEx([::Legends.Background.LegendLegionSlave]);
		bros[1].setPlaceInFormation(4);
		local items = bros[1].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[2].setStartValuesEx([::Legends.Background.LegendLegionSlave]);
		bros[2].setPlaceInFormation(5);
		local items = bros[2].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[3].setStartValuesEx([::Legends.Background.LegendLegionSlave]);
		bros[3].setPlaceInFormation(12);
		local items = bros[3].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[4].setStartValuesEx([::Legends.Background.LegendLegionAuxiliary]);
		bros[4].setPlaceInFormation(13);
		local items = bros[4].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[5].setStartValuesEx([::Legends.Background.LegendLegionAuxiliary]);
		bros[5].setPlaceInFormation(14);
		local items = bros[5].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[6].setStartValuesEx([::Legends.Background.LegendLegionLegionary]);
		bros[6].setPlaceInFormation(21);
		local items = bros[6].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));

		bros[7].setStartValuesEx([::Legends.Background.LegendLegionLegionary]);
		bros[7].setPlaceInFormation(23);
		local items = bros[7].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));

		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.getStash().resize(::World.Assets.getStash().getCapacity() + 9);

	}

	function onSpawnPlayer() {
		local towns = ::World.EntityManager.getSettlements().filter(@(_, s) ! s.isMilitary() && s.getAttachedLocations().filter(@(_,_loc) (_loc.getTypeID() != "attached_location.harbor")).len() > 0);
		local nearestVillage = null;

		local priorities = [
			{
				size = 1,
				terrain = ::Const.World.TerrainType.Steppe
			},
			{
				size = 2,
				terrain = ::Const.World.TerrainType.Steppe
			},
			{
				size = 3,
				terrain = ::Const.World.TerrainType.Steppe
			},
			{
				size = 1,
				terrain = ::Const.World.TerrainType.Plains
			},
			{
				size = 2,
				terrain = ::Const.World.TerrainType.Plains
			},
			{
				size = 3,
				terrain = ::Const.World.TerrainType.Plains
			}
		];

		foreach (p in priorities) {
			local validTowns = towns.filter(@(_, _town) _town.getSize() == p.size && _town.getTile().Type == p.terrain);

			if (validTowns.len() > 0) {
				nearestVillage = validTowns[::Math.rand(0, validTowns.len() - 1)];
				break;
			}
		}

		local attachedLocations = nearestVillage.getAttachedLocations();
		local villageTile = nearestVillage.getTile();
		local closestLocation = null;
		local dist = 99999;

		foreach (a in attachedLocations.filter(@(_, _loc)(_loc.getTypeID() != "attached_location.harbor"))) {
			local distanceToVillage = a.getTile().getDistanceTo(villageTile);
			if ((distanceToVillage < dist)) {
				dist = distanceToVillage;
				closestLocation = a;
			}
		}

		local spawnTile = nearestVillage.getTile();
		if (closestLocation != null) {
			closestLocation.setActive(false);
			closestLocation.spawnFireAndSmoke();
			spawnTile = closestLocation.getTile();
		}

		foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.Settlement)) {
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse)) {
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState)) {
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		foreach (n in ::World.FactionManager.getFactionsOfType(::Const.FactionType.Undead)) {
			n.addPlayerRelation(400.0, "For the empire!");
		}

		this.m.StaticRelationsToFaction[::Const.FactionType.Settlement] = true;
		this.m.StaticRelationsToFaction[::Const.FactionType.NobleHouse] = true;
		this.m.StaticRelationsToFaction[::Const.FactionType.OrientalCityState] = true;
		this.m.StaticRelationsToFaction[::Const.FactionType.Undead] = true;
		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", spawnTile.Coords.X, spawnTile.Coords.Y);
		::World.Assets.updateLook(112);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function (_tag) {
			::Music.setTrackList(["music/undead_01.ogg"], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.legend_risen_legion_intro");
		}, null);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Gatherer], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Crafting], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Fletcher], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Healer], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Kitchen], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Scout], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Workshop], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Training], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Barber], true);
		::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Painter], true);
	}

	function onUpdateHiringRoster(_roster) {
		local garbage = [];
		local bros = _roster.getAll();

		foreach (_, bro in bros) {
			if (bro.isStabled()) {
				continue;
			}

			if (!bro.isStabled()) {
				garbage.push(bro);
			}
		}

		foreach (g in garbage) {
			_roster.remove(g);
		}
	}
});
