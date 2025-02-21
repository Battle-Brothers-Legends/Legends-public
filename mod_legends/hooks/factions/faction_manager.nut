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
		if (this.m.LastRelationUpdateDay != this.World.getTime().Days)
		{
			this.m.LastRelationUpdateDay = this.World.getTime().Days;
			local StaticRelations = this.World.Assets.getOrigin().getStaticRelations();

			foreach( f in this.m.Factions )
			{
				if (f != null)
				{
					if ( !(StaticRelations[f.getType()]) ) 		//init to false automatically so should
					{											//normalize relations unless we set in scenario init
						f.normalizeRelation();
					}
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

	o.runSimulation = function ()
	{
		this.logInfo("Running simulation for " + this.Const.Factions.CyclesOnNewCampaign + " cycles...");
		this.LoadingScreen.updateProgress("Simulating World ... 0%");

		local barbarians = this.Const.DLC.Wildmen ? this.getFactionOfType(this.Const.FactionType.Barbarians) : null;
		local bandits = this.getFactionOfType(this.Const.FactionType.Bandits);
		local nomads = this.Const.DLC.Desert ? this.getFactionOfType(this.Const.FactionType.OrientalBandits) : null;
		local orcs = this.getFactionOfType(this.Const.FactionType.Orcs);
		local goblins = this.getFactionOfType(this.Const.FactionType.Goblins);
		local undead = this.getFactionOfType(this.Const.FactionType.Undead);
		local zombies = this.getFactionOfType(this.Const.FactionType.Zombies);
		local beasts = this.getFactionOfType(this.Const.FactionType.Beasts);
		local freecompanies = this.getFactionOfType(this.Const.FactionType.FreeCompany);

		for( local i = 0; i < this.Const.Factions.CyclesOnNewCampaign; i = ++i )
		{
			if (barbarians != null)
			{
				barbarians.update(true, true);
			}

			if (nomads != null)
			{
				nomads.update(true, true);
			}

			bandits.update(true, true);
			goblins.update(true, true);
			orcs.update(true, true);
			undead.update(true, true);
			zombies.update(true, true);
			beasts.update(true, true);
			freecompanies.update(true, true);
			if (i % 20 == 0)
			{
				local progress = (i * 1.0) / (this.Const.Factions.CyclesOnNewCampaign * 1.0);
				this.LoadingScreen.updateProgress("Simulating World ... " + progress  * 100 + "%");
			}
			this.__ping();
		}

		foreach(settlement in this.World.EntityManager.getSettlements() )
		{
			settlement.updateShop(true);
		}
	}

	local createFactions = o.createFactions;
	o.createFactions = function ()
	{
		m.IsCreatingFactions = true;
		createFactions();
		m.IsCreatingFactions = false;
	}

	local createAlliances = o.createAlliances;
	o.createAlliances = function()
	{
		if (m.IsCreatingFactions) {
			createFreeCompany();
			createDummyFaction();
		}

		createAlliances();
	}

	o.createFreeCompany <- function ()
	{
		local f = this.new("scripts/factions/legend_free_company_faction");
		f.setID(this.m.Factions.len());
		f.setName("Free Companies");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.FreeCompany);
		this.m.Factions.push(f);
	}

	o.createDummyFaction <- function ()
	{
		local f = this.new("scripts/factions/legend_dummy_faction");
		f.setID(this.m.Factions.len());
		f.setName("Dummy Faction");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.DummyFaction);
		this.m.Factions.push(f)
	}

	o.createNobleHouses = function()
	{
		local _num = ::Legends.Mod.ModSettings.getSetting("Factions").getValue();
		local banners = [];
		local names = [];
		local nobleHouses = [];

		local houses = this.Const.GetFactionArchetypesList();
		for (local i = 0; i < _num; i = ++i)
		{
			local index = houses.remove(this.Math.rand(0, houses.len() - 1));
			local a = this.Const.FactionArchetypes[index[0]][index[1]];
			local f = this.new("scripts/factions/noble_faction");
			local banner;

			do
			{
				banner = this.Math.rand(2, 10);
			}
			while (banners.find(banner) != null);

			banners.push(banner);
			local name;

			do
			{
				name = this.Const.Strings.NobleHouseNames[this.Math.rand(0, this.Const.Strings.NobleHouseNames.len() - 1)];
			}
			while (names.find(name) != null);

			names.push(name);
			f.setID(this.m.Factions.len());
			f.setName(name);
			f.setMotto("\"" + a.Mottos[this.Math.rand(0, a.Mottos.len() - 1)] + "\"");
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
		local settlements = this.World.EntityManager.getSettlements();
		local military = [];
		local civilian = [];

		for( local i = 0; i < settlements.len(); i = ++i )
		{
			if (this.isKindOf(settlements[i], "city_state"))
			{
			}
			else if (settlements[i].isMilitary())
			{
				military.push(settlements[i]);
			}
			else
			{
				civilian.push(settlements[i]);
			}
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
				other = this.Math.rand(0, _nobleHouses.len() - 1);
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

			foreach( i, n in _nobleHouses )
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

		local mapSize = this.World.getMapSize();
		local northernTile = this.World.getTileSquare(mapSize.X / 2, mapSize.Y - 1);
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Goblins)
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Bandits)
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Zombies)
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Undead)
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Beasts)
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
			else if (this.m.Factions[i].getType() == this.Const.FactionType.NobleHouse)
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
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local randomHouseID = nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getID();
		//	local camp = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse).getNearestSettlement(this.World.State.getPlayer().getTile());
		//	local nearestHouseID = nearestSettlement.getOwner().getID();
		//	local destination = this.WeakTableRef(camp);
		local settlements = this.World.EntityManager.getSettlements();
		foreach( s in settlements )
		{
		if (s.getOwner() != null && s.getOwner().getID() == randomHouseID && s.isMilitary())
			{
			s.setDiscovered(true);
			this.World.uncoverFogOfWar(s.getTile().Pos, 500.0);
			}
		}

		this.World.FactionManager.getFaction(randomHouseID).setPlayerRelation(80.0);
		this.logInfo("Making a noble house friendly");

	}

	o.makeRandomNoblesUnfriendlyToPlayer <- function ()
	{
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local randomHouseID = nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getID();
		this.World.FactionManager.getFaction(randomHouseID).setPlayerRelation(-80.0);
		this.logInfo("Making a noble house unfriendly");
	}


	o.makeSettlementsUnfriendlyToPlayer <- function ()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Settlement)
			{
				if (this.m.Factions[i].getPlayerRelation() > -80)
				{
					this.m.Factions[i].setPlayerRelation(-80.0);
					this.logInfo("Making settlement unfriendly");
				}
			}
		}
	}

	o.makeRandomSettlementFriendlyToPlayer <- function ()
	{
		local settlements = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement);
		local randomSettlementID = settlements[this.Math.rand(0, settlements.len() - 1)].getID();
		this.World.FactionManager.getFaction(randomSettlementID).setPlayerRelation(50.0);
		this.logInfo("Making a settlement friendly");
		local settlements = this.World.EntityManager.getSettlements();
		foreach( s in settlements )
		{
		if (s.getOwner() != null && s.getOwner().getID() == randomHsettlementID)
			{
			s.setDiscovered(true);
			this.World.uncoverFogOfWar(s.getTile().Pos, 500.0);
			}
		}
	}

	o.updateGreaterEvil = function ()
	{
		local GE = this.m.GreaterEvil;


		if (GE.Type == this.Const.World.GreaterEvilType.None)
		{
			return;
		}

		if (GE.NextPhaseTime == 0.0)
		{
			GE.NextPhaseTime = this.Time.getVirtualTimeF() + this.Math.rand(50, 60) * this.World.getTime().SecondsPerDay;

			if (this.World.Assets.isIronman())
			{
				GE.NextPhaseTime += 5.0 * this.World.getTime().SecondsPerDay;
			}

			if (this.World.Assets.getCombatDifficulty() == 0)
			{
				GE.NextPhaseTime += 5.0 * this.World.getTime().SecondsPerDay;
			}
			if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
			{
				GE.NextPhaseTime = 1; // Just a small non-zero number so that this code doesn't repeat and so that it starts doing the code below which only runs when this number is less than the current time.
			}

		}
		else if (GE.NextPhaseTime <= this.Time.getVirtualTimeF())
		{
			if (GE.Phase == this.Const.World.GreaterEvilPhase.NotSet && (this.World.State.getPlayer().getStrength() >= 160 || this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition"))
			{
				this.logInfo("STARTING GREATER EVIL - WARNING PHASE!");
				GE.Phase = this.Const.World.GreaterEvilPhase.Warning;
				GE.NextPhaseTime = this.Time.getVirtualTimeF() + 20 * this.World.getTime().SecondsPerDay;

				if (GE.Type == 0)
				{
					local possibilities = [];

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.CivilWar) == 0 && this.isNoblesFeuding())
					{
						possibilities.push(this.Const.World.GreaterEvilType.CivilWar);
					}

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.Greenskins) == 0)
					{
						possibilities.push(this.Const.World.GreaterEvilType.Greenskins);
					}

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.Undead) == 0)
					{
						possibilities.push(this.Const.World.GreaterEvilType.Undead);
					}

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.HolyWar) == 0 && this.Const.DLC.Desert && this.isCityStateExisting() && this.isNoblesFeuding())
					{
						possibilities.push(this.Const.World.GreaterEvilType.HolyWar);
					}

					if (possibilities.len() != 0)
					{
						GE.Type = possibilities[this.Math.rand(0, possibilities.len() - 1)];
					}
					else
					{
						if (GE.LastType != this.Const.World.GreaterEvilType.CivilWar && this.isNoblesFeuding())
						{
							possibilities.push(this.Const.World.GreaterEvilType.CivilWar);
						}

						if (GE.LastType != this.Const.World.GreaterEvilType.Greenskins)
						{
							possibilities.push(this.Const.World.GreaterEvilType.Greenskins);
						}

						if (GE.LastType != this.Const.World.GreaterEvilType.Undead || this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
						{
							possibilities.push(this.Const.World.GreaterEvilType.Undead);
						}

						if (GE.LastType != this.Const.World.GreaterEvilType.HolyWar && this.Const.DLC.Desert && this.isCityStateExisting() && this.isNoblesFeuding())
						{
							possibilities.push(this.Const.World.GreaterEvilType.HolyWar);
						}

						GE.Type = possibilities[this.Math.rand(0, possibilities.len() - 1)];
					}
				}
			}
			else if (GE.Phase == this.Const.World.GreaterEvilPhase.Warning && (this.World.State.getPlayer().getStrength() >= 180  || this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition"))
			{
				this.logInfo("STARTING GREATER EVIL - LIVE PHASE!");
				GE.Phase = this.Const.World.GreaterEvilPhase.Live;
				GE.Strength = this.Const.Factions.GreaterEvilStartStrength;
				this.World.Statistics.clearNews();

				if (GE.Type == this.Const.World.GreaterEvilType.CivilWar)
				{
					this.World.Statistics.addNews("crisis_civilwar_start", this.World.Statistics.createNews());
					GE.Strength -= 10.0;
					this.breakNobleHouseAlliances();
				}
				else if (GE.Type == this.Const.World.GreaterEvilType.Greenskins)
				{
					this.World.Statistics.addNews("crisis_greenskins_start", this.World.Statistics.createNews());
					this.getFactionOfType(this.Const.FactionType.Orcs).addAlly(this.getFactionOfType(this.Const.FactionType.Goblins).getID());
					this.getFactionOfType(this.Const.FactionType.Goblins).addAlly(this.getFactionOfType(this.Const.FactionType.Orcs).getID());
				}
				else if (GE.Type == this.Const.World.GreaterEvilType.Undead)
				{
					this.World.Statistics.addNews("crisis_undead_start", this.World.Statistics.createNews());
				}
				else if (GE.Type == this.Const.World.GreaterEvilType.HolyWar)
				{
					this.World.Statistics.addNews("crisis_holywar_start", this.World.Statistics.createNews());
					GE.Strength -= 10.0;
					this.breakNorthSouthAlliances();
				}
			}
			else if (GE.Phase == this.Const.World.GreaterEvilPhase.Live)
			{
				if (GE.Type == 0)
				{
					GE.Phase = 0;
					return;
				}

				if (GE.LastUpdate != this.World.getTime().Days)
				{
					GE.Strength += this.Const.Factions.GreaterEvilDailyStrength;
					GE.LastUpdate = this.World.getTime().Days;
				}

				if ((GE.Strength <= 0 || GE.Type == this.Const.World.GreaterEvilType.CivilWar && !this.isNoblesFeuding()) && this.World.Contracts.getActiveContract() == null)
				{
					this.World.Statistics.clearNews();

					if (GE.Type == this.Const.World.GreaterEvilType.CivilWar)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.CivilWar;
						this.World.Statistics.addNews("crisis_civilwar_end", this.World.Statistics.createNews());
					}
					else if (GE.Type == this.Const.World.GreaterEvilType.Greenskins)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.Greenskins;
						this.World.Statistics.addNews("crisis_greenskins_end", this.World.Statistics.createNews());
						this.getFactionOfType(this.Const.FactionType.Orcs).removeAlly(this.getFactionOfType(this.Const.FactionType.Goblins).getID());
						this.getFactionOfType(this.Const.FactionType.Goblins).removeAlly(this.getFactionOfType(this.Const.FactionType.Orcs).getID());
					}
					else if (GE.Type == this.Const.World.GreaterEvilType.Undead)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.Undead;
						this.World.Statistics.addNews("crisis_undead_end", this.World.Statistics.createNews());
					}
					else if (GE.Type == this.Const.World.GreaterEvilType.HolyWar)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.HolyWar;
						this.World.Statistics.addNews("crisis_holywar_end", this.World.Statistics.createNews());
					}

					this.World.Combat.abortAll();
					GE.LastType = GE.Type;
					GE.Type = this.Const.World.GreaterEvilType.Random;
					GE.Phase = this.Const.World.GreaterEvilPhase.NotSet;
					GE.NextPhaseTime = this.Time.getVirtualTimeF() + this.Math.rand(25, 35) * this.World.getTime().SecondsPerDay;
					this.World.Statistics.getFlags().increment("GreaterEvilsDefeated");
				}
			}
		}
	}

	o.onSerialize = function ( _out )
	{
		local numFactions = 0;

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			numFactions = ++numFactions;
		}

		_out.writeU8(numFactions);

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			_out.writeI32(f.ClassNameHash);
		}

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			f.onSerialize(_out);
		}

		_out.writeU32(this.m.LastRelationUpdateDay);
		_out.writeU8(this.m.GreaterEvil.Type);
		_out.writeU8(this.m.GreaterEvil.LastType);
		_out.writeU32(this.m.GreaterEvil.TypesUsed);
		_out.writeU8(this.m.GreaterEvil.Phase);
		_out.writeF32(this.m.GreaterEvil.NextPhaseTime);
		_out.writeF32(this.m.GreaterEvil.Strength);
		_out.writeF32(this.m.GreaterEvil.LastUpdate);
	}

	o.onDeserialize = function ( _in )
	{
		this.clear();
		local numFactions = _in.readU8();

		for( local i = 0; i != numFactions; i = ++i )
		{
			local f = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			this.m.Factions.push(f);
		}

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			f.onDeserialize(_in);
		}

		this.createDummyFaction();

		// Setup the dummy faction's mimic behaviour after all possible factions have been deserialized
		local dummy = this.getDummyFaction();
		dummy.setMimicValues(dummy.getMimicID());

		this.m.LastRelationUpdateDay = _in.readU32();
		this.m.GreaterEvil.Type = _in.readU8();
		this.m.GreaterEvil.LastType = _in.readU8();
		this.m.GreaterEvil.TypesUsed = _in.readU32();
		this.m.GreaterEvil.Phase = _in.readU8();
		this.m.GreaterEvil.NextPhaseTime = _in.readF32();
		this.m.GreaterEvil.Strength = _in.readF32();
		this.m.GreaterEvil.LastUpdate = _in.readF32();
	}
});
