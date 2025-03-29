::mods_hookExactClass("entity/world/combat_manager", function(o)
{
	o.startCombat = function( _p1, _p2 )
	{
		local p1 = typeof _p1 == "instance" ? _p1.get() : _p1;
		local p2 = typeof _p2 == "instance" ? _p2.get() : _p2;

		if (!p1.isAttackable() || !p2.isAttackable())
		{
			this.logError("Entity cannot be attacked!");
			return;
		}

		if (p1.isInCombat() && p2.isInCombat())
		{
			return;
		}

		p1.onBeforeCombatStarted();
		p2.onBeforeCombatStarted();

		if (!p1.isAlive() || !p2.isAlive())
		{
			return;
		}

		if (p1.getTroops().len() == 0 || p2.getTroops().len() == 0)
		{
			return;
		}

		if (!p1.isInCombat() && p2.isInCombat())
		{
			foreach( combat in this.m.Combats )
			{
				if (combat.ID == p2.getCombatID())
				{
					this.joinCombat(combat, p1);
					return;
				}
			}
		}
		else if (p1.isInCombat() && !p2.isInCombat())
		{
			foreach( combat in this.m.Combats )
			{
				if (combat.ID == p1.getCombatID())
				{
					this.joinCombat(combat, p2);
					return;
				}
			}
		}

		local stats = {
			Dead = 0,
			Loot = []
		};
		local combat = {
			ID = this.m.NextCombatID,
			IsResolved = false,
			Stats = stats,
			Combatants = [],
			Factions = []
		};
		this.m.NextCombatID += 1;
		local numFactions = 128;
		// if (p1.getFaction() >= numFactions) {
		// 	numFactions = p1.getFaction() + 1;
		// }
		// if (p2.getFaction() >= numFactions) {
		// 	numFactions = p2.getFaction() + 1;
		// }

		combat.Factions.resize(numFactions);

		for( local f = 0; f != numFactions; f = ++f )
		{
			combat.Factions[f] = [];
		}

		this.joinCombat(combat, p1);
		this.joinCombat(combat, p2);
		this.m.Combats.push(combat);
	}

	o.tickCombat = function ( _combat )
	{
		local attackOccured = false;
		if (_combat.Combatants == null || _combat.Combatants.len() == 0)
		{
			_combat.Combatants = [];
			_combat.IsResolved = true;
			return
		}

		if (_combat.Factions == null || _combat.Factions.len() == 0)
		{
			_combat.Factions = [];
			_combat.IsResolved = true;
			return
		}

		for( local i = 0; i < _combat.Combatants.len(); i = ++i )
		{
			local combatant = _combat.Combatants[i];

			if (combatant.Party == null || combatant.Party.isNull())
			{
				continue;
			}

			local potentialOpponentFactions = [];

			for( local f = 0; f < _combat.Factions.len(); f = ++f )
			{
				local lFaction = _combat.Factions[f];
				if (lFaction == null || lFaction.len() == 0)
				{
					continue
				}

				if (combatant.Party.getFaction() != f && !this.World.FactionManager.isAllied(combatant.Party.getFaction(), f))
				{
					potentialOpponentFactions.push(f);
				}
			}

			if (potentialOpponentFactions.len() == 0)
			{
				continue;
			}

			local opponentFaction = potentialOpponentFactions[this.Math.rand(0, potentialOpponentFactions.len() - 1)];
			local opponentParty = _combat.Factions[opponentFaction][this.Math.rand(0, _combat.Factions[opponentFaction].len() - 1)];

			if (opponentParty == null || opponentParty.isNull() || opponentParty.getTroops().len() == 0)
			{
				continue;
			}

			local opponentIndex = this.Math.rand(0, opponentParty.getTroops().len() - 1);
			local opponent = opponentParty.getTroops()[opponentIndex];
			attackOccured = true;
			opponent.Strength -= this.Math.max(1, this.Math.rand(1, combatant.Strength) * this.Const.World.CombatSettings.CombatStrengthMult);

			if (opponent.Strength <= 0)
			{
				++_combat.Stats.Dead;
				opponentParty.getTroops().remove(opponentIndex);
				opponentIndex = _combat.Combatants.find(opponent);
				_combat.Combatants.remove(opponentIndex);

				if (opponentIndex < i)
				{
					i = --i;
				}

				if (opponentParty.getTroops().len() == 0)
				{
					_combat.Stats.Loot.extend(opponentParty.getInventory());
					local partyIndex = _combat.Factions[opponentParty.getFaction()].find(opponentParty);
					opponentParty.setCombatID(0);
					_combat.Factions[opponentParty.getFaction()].remove(partyIndex);
					opponentParty.onCombatLost();
				}
			}

		}

		if (!attackOccured)
		{
			_combat.IsResolved = true;
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.clear();
		this.m.NextCombatID = _in.readI32();
		local numCombats = _in.readU16();

		for( local i = 0; i < numCombats; i = ++i )
		{
			local stats = {
				Dead = 0,
				Loot = []
			};
			local combat = {
				ID = 0,
				IsResolved = false,
				Stats = stats,
				Combatants = [],
				Factions = []
			};
			combat.Factions.resize(128);

			for( local f = 0; f != 128; f = ++f )
			{
				combat.Factions[f] = [];
			}

			combat.ID = _in.readI32();
			combat.IsResolved = _in.readBool();
			combat.Stats.Dead = _in.readI32();
			local numLoot = _in.readU16();

			for( local i = 0; i != numLoot; i = ++i )
			{
				combat.Stats.Loot.push(_in.readString());
			}

			local numParties = _in.readU16();

			for( local p = 0; p < numParties; p = ++p )
			{
				local party = this.World.getEntityByID(_in.readU32());
				// if (party.getFaction() >= combat.len()) {
				// 	combat.Factions.resize(party.getFaction() + 1);
				// 	for( local f = party.getFaction(); f != party.getFaction() + 1; f = ++f )
				// 	{
				// 		combat.Factions[f] = [];
				// 	}
				// }
				this.joinCombat(combat, party);
			}

			this.m.Combats.push(combat);
		}
	}
});
