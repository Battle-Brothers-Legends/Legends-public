::mods_hookNewObject("factions/faction_manager", function(o)
{
	o.m.IsCreatingFactions <- false;

	o.setGreaterEvilType <- function ( _type )
	{
		return this.m.GreaterEvil.Type = _type;
	}

	o.setGreaterEvilPhase <- function  ( _phase )
	{
		return this.m.GreaterEvil.Phase = _phase;
	}

	o.getDummyFaction <- function ()
	{
		return this.getFactionOfType(::Const.FactionType.DummyFaction); // there should only be 1 DummyFaction
	}

	o.update = function ( _ignoreDelay = false )
	{
		if (this.m.LastRelationUpdateDay != ::World.getTime().Days)
		{
			this.m.LastRelationUpdateDay = ::World.getTime().Days;
			local StaticRelations = ::World.Assets.getOrigin().getStaticRelations();

			foreach( f in this.m.Factions )
			{
				if (f != null && !(StaticRelations[f.getType()])) //init to false automatically so should
				{ //normalize relations unless we set in scenario init
					f.normalizeRelation();
				}
			}
		}

		if (++this.m.NextFactionToUpdate >= this.m.Factions.len())
		{
			this.m.NextFactionToUpdate = 3;
		}

		if (this.m.Factions[this.m.NextFactionToUpdate] != null)
		{
			this.m.Factions[this.m.NextFactionToUpdate].update(_ignoreDelay, false);
		}

		this.updateGreaterEvil();
	}

	local runSimulation = o.runSimulation;
	o.runSimulation = function ()
	{
		runSimulation();

		foreach(settlement in ::World.EntityManager.getSettlements() )
		{
			settlement.updateShop(true);
		}
	}

	local createFactions = o.createFactions;
	o.createFactions = function () {
		this.m.IsCreatingFactions = true;
		createFactions();
		this.m.IsCreatingFactions = false;
	}

	local createAlliances = o.createAlliances;
	o.createAlliances = function() {
		if (this.m.IsCreatingFactions) {
			this.createFreeCompany();
			this.createDummyFaction();
			local dummy = this.getDummyFaction();
			// Setup the dummy faction's mimic behaviour after all possible factions have been deserialized
			dummy.setMimicValues(dummy.getMimicID());
		}

		createAlliances();
	}

	o.createFreeCompany <- function ()
	{
		local f = this.new("scripts/factions/legend_free_company_faction");
		f.setID(this.m.Factions.len());
		f.setName("Free Companies");
		f.setDiscovered(true);
		f.addTrait(::Const.FactionTrait.FreeCompany);
		this.m.Factions.push(f);
	}

	o.createDummyFaction <- function ()
	{
		local f = this.new("scripts/factions/legend_dummy_faction");
		f.setID(this.m.Factions.len());
		f.setName("Dummy Faction");
		f.setDiscovered(true);
		f.addTrait(::Const.FactionTrait.DummyFaction);
		this.m.Factions.push(f);
	}

	o.createNobleHouses = function()
	{
		local _num = ::Legends.Mod.ModSettings.getSetting("Factions").getValue();
		local banners = [];
		local names = [];
		local nobleHouses = [];

		local houses = ::Const.GetFactionArchetypesList();
		for (local i = 0; i < _num; i = ++i)
		{
			local index = houses.remove(::Math.rand(0, houses.len() - 1));
			local a = ::Const.FactionArchetypes[index[0]][index[1]];
			local f = this.new("scripts/factions/noble_faction");
			local banner;

			do
			{
				banner = ::Math.rand(2, 10);
			}
			while (banners.find(banner) != null);

			banners.push(banner);
			local name;

			do
			{
				name = ::Const.Strings.NobleHouseNames[::Math.rand(0, ::Const.Strings.NobleHouseNames.len() - 1)];
			}
			while (names.find(name) != null);

			names.push(name);
			f.setID(this.m.Factions.len());
			f.setName(name);
			f.setMotto("\"" + a.Mottos[::Math.rand(0, a.Mottos.len() - 1)] + "\"");
			f.setDescription(a.Description);
			f.setBanner(banner);
			f.setDiscovered(true);

			foreach( t in a.Traits )
			{
				f.addTrait(t);
			}

			this.m.Factions.push(f);
			nobleHouses.push(f);
		}

		return nobleHouses;
	}

	o.assignSettlementsToNobleHouses = function ( _nobleHouses )
	{
		local settlements = ::World.EntityManager.getSettlements();
		local military = [];
		local civilian = [];

		foreach(t in settlements) {
			if (t.isSouthern())
				continue;
			if (t.isMilitary())
				military.push(t);
			else
				civilian.push(t);
		}

		military.sort(this.onSizeCompare);

		foreach( i, n in _nobleHouses )
		{
			if (military.len() > 0)
			{
				n.addSettlement(military[0]);
				military.remove(0);
			}
			local other;
			do
			{
				other = ::Math.rand(0, _nobleHouses.len() - 1);
			}
			while (other == i);

			local description = n.getDescription();
			local vars = [
				[
					"noblehousename",
					n.getNameOnly()
				],
				[
					"regionname",
					""
				],
				[
					"factionfortressname",
					n.getSettlements()[0].getName()
				],
				[
					"othernoblehouse",
					_nobleHouses[other].getNameOnly()
				]
			];
			n.setDescription(this.buildTextFromTemplate(description, vars));
		}

		military.extend(civilian);

		foreach( s in military )
		{
			local best;
			local bestAvgDist = 9000.0;

			foreach( _, n in _nobleHouses )
			{
				local locales = n.getSettlements();
				local avgDist = 0.0;

				foreach( l in locales )
				{
					avgDist = avgDist + l.getTile().getDistanceTo(s.getTile());
				}

				avgDist = avgDist / locales.len();
				avgDist = avgDist + locales.len();

				if (avgDist < bestAvgDist)
				{
					bestAvgDist = avgDist;
					best = n;
				}
			}

			if (best != null)
			{
				best.addSettlement(s);
			}
		}

		local mapSize = ::World.getMapSize();
		local northernTile = ::World.getTileSquare(mapSize.X / 2, mapSize.Y - 1);
		local houses = [];

		foreach( n in _nobleHouses )
		{
			local closest;
			local dist = 9999;

			foreach( s in n.getSettlements() )
			{
				local d = s.getTile().getDistanceTo(northernTile);

				if (d < dist)
				{
					dist = d;
					closest = s;
				}
			}

			houses.push({
				Faction = n,
				Dist = dist
			});
		}

		houses.sort(function ( _a, _b )
		{
			if (_a.Dist > _b.Dist)
			{
				return -1;
			}
			else if (_a.Dist < _b.Dist)
			{
				return 1;
			}

			return 0;
		});

		for( local i = 0; i < 2; i = ++i )
		{
			houses[i].Faction.getFlags().set("IsHolyWarParticipant", true);
		}
	}

	o.makeGoblinsFriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Goblins)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
					this.logInfo("Making goblins friendly");
				}
			}
		}
	}

	o.makeBanditsFriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Bandits)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
					this.logInfo("Making bandits friendly");
				}
			}
		}
	}

	o.makeZombiesFriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Zombies)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
					this.logInfo("Making zombies friendly");
				}
			}
		}
	}

	o.makeUndeadFriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Undead)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
					this.logInfo("Making undead friendly");
				}
			}
		}
	}

	o.makeBeastsFriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Beasts)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
					this.logInfo("Making beasts friendly");
				}
			}
		}
	}

	o.makeNoblesUnfriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.NobleHouse)
			{
				if (this.m.Factions[i].getPlayerRelation() > -80)
				{
					this.m.Factions[i].setPlayerRelation(-80.0);
					this.logInfo("Making nobles unfriendly");
				}
			}
		}
	}

	o.makeRandomNoblesFriendlyToPlayer <- function ()
	{
		local nobleHouses = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
		local randomHouseID = nobleHouses[::Math.rand(0, nobleHouses.len() - 1)].getID();
		//	local camp = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse).getNearestSettlement(::World.State.getPlayer().getTile());
		//	local nearestHouseID = nearestSettlement.getOwner().getID();
		//	local destination = this.WeakTableRef(camp);
		local settlements = ::World.EntityManager.getSettlements();
		foreach( s in settlements )
		{
		if (s.getOwner() != null && s.getOwner().getID() == randomHouseID && s.isMilitary())
			{
			s.setDiscovered(true);
			::World.uncoverFogOfWar(s.getTile().Pos, 500.0);
			}
		}

		::World.FactionManager.getFaction(randomHouseID).setPlayerRelation(80.0);
		this.logInfo("Making a noble house friendly");

	}

	o.makeRandomNoblesUnfriendlyToPlayer <- function ()
	{
		local nobleHouses = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
		local randomHouseID = nobleHouses[::Math.rand(0, nobleHouses.len() - 1)].getID();
		::World.FactionManager.getFaction(randomHouseID).setPlayerRelation(-80.0);
		this.logInfo("Making a noble house unfriendly");
	}


	o.makeSettlementsUnfriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.Settlement)
			{
				if (this.m.Factions[i].getPlayerRelation() > -80)
				{
					this.m.Factions[i].setPlayerRelation(-80.0);
					this.logInfo("Making settlement unfriendly");
				}
			}
		}
	}

	o.makeRandomSettlementFriendlyToPlayer <- function () {
		local settlements = ::World.FactionManager.getFactionsOfType(::Const.FactionType.Settlement);
		local randomSettlementID = settlements[::Math.rand(0, settlements.len() - 1)].getID();
		::World.FactionManager.getFaction(randomSettlementID).setPlayerRelation(50.0);
		this.logInfo("Making a settlement friendly");
		local settlements = ::World.EntityManager.getSettlements();
		foreach( s in settlements )
		{
		if (s.getOwner() != null && s.getOwner().getID() == this.randomHsettlementID)
			{
			s.setDiscovered(true);
			::World.uncoverFogOfWar(s.getTile().Pos, 500.0);
			}
		}
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in ) {
		onDeserialize(_in);
		local dummy = this.getDummyFaction();
		if (dummy != null)
			dummy.setMimicValues(dummy.getMimicID()); // Setup the dummy faction's mimic behaviour after all possible factions have been deserialized
	}
});
