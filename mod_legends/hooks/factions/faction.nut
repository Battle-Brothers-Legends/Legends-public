::mods_hookBaseClass("factions/faction", function ( o )
{
	while(!("Flags" in o.m)) o=o[o.SuperName];

	/** Added to provide party in hooks */
	o.m.SpawnListener <- null;

	o.m.ContractsByCategory <-
	{
		Economy = [],
		Battle = [],
		Hunt = [],
		Legendary = [],
		Wildcard = []
	};

	o.getPlayerRelationAsText = function ()
	{
		if (this.m.PlayerRelation <= 0)
		{
			this.m.PlayerRelation = 1
		}
		return this.Const.Strings.Relations[this.Math.min(this.Const.Strings.Relations.len() - 1, this.m.PlayerRelation / 10)];
	}

	local addContract = o.addContract;
	o.addContract = function ( _c )
	{
		// Contract Overhaul
		// For the current phase, we will overhaul the system for Settlement contracts only
		if (this.getType() == this.Const.FactionType.Settlement)
		{
			_c.setFaction(this.getID());
			// During deserialization, if we detect the StoredAsWildcard flag, then we should straightaway push it there and finish
			if ( _c.m.Flags.get("StoredAsWildcard"))
			{
				this.m.Contracts.push(_c); // We still need to push to this table because the game logic relies on it to make the contract available in the settlement
				this.m.ContractsByCategory["Wildcard"].push(_c);
				return;
			}

			// Now we proceed with the actual logic
			local s = this.getSettlements()[0];
			local tier = s.getSize() - 1;
			local cat = _c.getCategory();

			// Just push to Wildcard category in case of contracts lacking category or using an unrecognised category (this should help with submod and savegame compatibility)
			if (cat == "" || cat == null || !(cat in this.Const.Contracts.CategoryLimits))
			{
				_c.m.Flags.set("StoredAsWildcard", true);
				this.m.Contracts.push(_c);
				this.m.ContractsByCategory["Wildcard"].push(_c);

				local str = "Contract Overhaul: Settlement {" + s.getName() + "} has added Contract {" + _c.getName() + "} with missing or unrecognised Category {" + cat + "} to Slot {Wildcard}";
				::Legends.Mod.Debug.printWarning(str,::Const.LegendMod.Debug.Flags.ContractCategories);
				return;
			}

			// Push to the contract's corresponding category if there's room
			if (this.m.ContractsByCategory[cat].len() < this.Const.Contracts.CategoryLimits[cat][tier])
			{
				this.m.Contracts.push(_c);
				this.m.ContractsByCategory[cat].push(_c);

				local str = "Contract Overhaul: Settlement {" + s.getName() + "} has added Contract {" + _c.getName() + "} with Category {" + cat + "} to Slot {" + cat + "}";
				::Legends.Mod.Debug.printLog(str,::Const.LegendMod.Debug.Flags.ContractCategories);
				return;
			}
			// If not, push to the Wildcard category if there's room
			else if (this.m.ContractsByCategory["Wildcard"].len() < this.Const.Contracts.CategoryLimits["Wildcard"][tier])
			{
				_c.m.Flags.set("StoredAsWildcard", true); // this will be used during deserialization and contract removal to indicate that it should be pushed to/removed from the Wildcard category
				this.m.Contracts.push(_c);
				this.m.ContractsByCategory["Wildcard"].push(_c);

				local str = "Contract Overhaul: Settlement {" + s.getName() + "} has added Contract {" + _c.getName() + "} with Category {" + cat + "} to Slot {Wildcard}";
				::Legends.Mod.Debug.printLog(str,::Const.LegendMod.Debug.Flags.ContractCategories);
				return;
			}
			// If not, something is wrong (the contract should not have been generated if both its category and Wildcard are full)
			else
			{
				local error = "";
				error += "Failed to add contract: " + _c.getName() + " (category=" + cat + ") | Settlement: " + s.getName() + " (size=" + s.getSize() + ")";
				error += " | Existing contracts of relevant category: " + cat + "=" + this.m.ContractsByCategory[cat].len() + ", Wildcard=" + this.m.ContractsByCategory["Wildcard"].len();
				::Legends.Mod.Debug.printError(error,::Const.LegendMod.Debug.Flags.ContractCategories);
				return
			}
		}
		else
		{
			// For this phase of the Contract Categories Overhaul, non-Settlement factions will always get the contract
			addContract(_c);
		}
	}

	local removeContract = o.removeContract;
	o.removeContract = function (_c)
	{
		removeContract(_c);
		// Contract Overhaul: Also remove from Contract Category for Settlement factions
		if (this.getType() == this.Const.FactionType.Settlement)
		{
			local j = null;
			// If the contract was stored in the Wildcard slot, we will remove it from there
			if (_c.m.Flags.get("StoredAsWildcard"))
			{
				j = this.m.ContractsByCategory["Wildcard"].find(_c);
				if (j != null)
				{
					this.m.ContractsByCategory["Wildcard"].remove(j);
					return;
				}
			}
			// If not, we will remove it from the contract's corresponding Category
			else
			{
				local cat = _c.getCategory();

				// If there's no category, then something is wrong
				if (cat == "" || cat == null)
				{
					local error = "Attempting to remove contract: " + _c.getName() + " from {" + this.getName() + "}" + " but it has no Category";
					::Legends.Mod.Debug.printError(error,::Const.LegendMod.Debug.Flags.ContractCategories);
					return;
				}

				local j = this.m.ContractsByCategory[cat].find(_c);
				if (j != null)
				{
					local str = "Removing Contract " + _c.getName() + " with Category=" + _c.getCategory() + " from {" + this.getName() + "}";
					::Legends.Mod.Debug.printLog(str,::Const.LegendMod.Debug.Flags.ContractCategories);
					this.m.ContractsByCategory[cat].remove(j);
					return;
				}
			}

			// If we couldn't find the contract anywhere, then something is wrong
			if (j == null)
			{
				local error = "";
				error += "Attempting to remove contract: " + _c.getName();
				error += " (Category=" + _c.getCategory() + ",StoredAsWildcard=" + _c.m.Flags.get("StoredAsWildcard") + ")" + " from {" + this.getName() + "}";
				error += " but it could not be found in any Category";
				::Legends.Mod.Debug.printError(error,::Const.LegendMod.Debug.Flags.ContractCategories);
				return;
			}
		}
	}

	o.spawnHostileEntity <- function ( _tile, _name, _uniqueName, _template, _resources, _resetDummyFaction = true )
	{
		if (this.isAlliedWithPlayer())
		{
			local df = ::World.FactionManager.getDummyFaction();
			df.setMimicValues(this.getID(), _resetDummyFaction);
			return df.spawnEntity(_tile, _name, _uniqueName, _template, _resources);
		}
		else
		{
			return this.spawnEntity(_tile, _name, _uniqueName, _template, _resources);
		}
	}

	// Remove all occurrences of faction actions with the given ID from this.m.Deck
	// Note that during deserialization, this.addTrait will re-add all actions associated with the input trait as defined in faction_traits.nut
	o.removeActionByID <- function ( _id )
	{
		local reachedEnd = false;
		local startIndex = 0;

		while( !reachedEnd )
		{
			for (local i = startIndex; i < this.m.Deck.len(); i++)
			{
				if ( i == this.m.Deck.len() - 1 )
				{
					reachedEnd = true;
				}

				if ( this.m.Deck[i].getID() == _id )
				{
					this.m.Deck.remove(i);
					startIndex = i;
					break; // Each time we remove an action from the array, its length changes
				}
			}
		}
	}

	// Return true if the faction has existing contracts that are mutually exclusive with the input contract
	o.hasContractExclusion <- function ( _contractType )
	{
		foreach (arr in ::Const.Contracts.ContractExclusions)
		{
			if (arr.find(_contractType) != null)
			{
				foreach (contract in this.getContracts())
				{
					if (arr.find(contract.getType()) != null) return true;
				}
			}
		}

		return false;
	}

	o.setSpawnListener <- function (_listener) {
		this.m.SpawnListener = _listener;
	}

	local spawnEntity = o.spawnEntity;
	o.spawnEntity = function (_tile, _name, _uniqueName, _template, _resources, _minibossify = 0) {
		local entity = spawnEntity(_tile, _name, _uniqueName, _template, _resources, _minibossify);
		if (this.m.SpawnListener != null)
			this.m.SpawnListener(entity);
		this.m.SpawnListener = null;
		return entity;
	}
});
