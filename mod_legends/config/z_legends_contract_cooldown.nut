if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

::Const.LegendMod.ContractCooldown <- {

	// Increment the number of times in a row the player has taken a contract from the input faction
	// Refreshes if the input faction is different from the last faction
	function updateStreak( _faction )
	{
		// Contract Overhaul Phase 1
		// For Phase 1, we will overhaul the system for Settlement contracts only
		if (_faction.getType() == this.Const.FactionType.Settlement)
		{
			local name = _faction.getName();
			if (::World.Flags.get("LastContractSettlement") == name)
			{
				::World.Flags.increment("LastContractSettlementStreak",1);
				::Legends.Mod.Debug.printLog("Contract Streak incremented for " + name + ": " + ::World.Flags.get("LastContractSettlementStreak"), ::Const.LegendMod.Debug.Flags.ContractCategories);
			}
			else
			{
				::World.Flags.set("LastContractSettlement", name);
				::World.Flags.set("LastContractSettlementStreak",1);
				::Legends.Mod.Debug.printLog("Contract Streak started for " + name, ::Const.LegendMod.Debug.Flags.ContractCategories);
			}
		}
		else
		{
			::Legends.Mod.Debug.printLog("Ending Contract Streak at " + ::World.Flags.get("LastContractSettlement"), ::Const.LegendMod.Debug.Flags.ContractCategories);
			::World.Flags.remove("LastContractSettlement");
			::World.Flags.remove("LastContractSettlementStreak");
		}
	},

	// Get the number of times in a row the player has taken a contract from the input faction 
	function getStreak( _faction )
	{
		if (::World.Flags.get("LastContractSettlement") == _faction.getName())
		{
			::Legends.Mod.Debug.printLog("Settlement " + _faction.getName() + " has a Contract Streak: " + ::World.Flags.get("LastContractSettlementStreak"), ::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose);
			return ::World.Flags.get("LastContractSettlementStreak");
		}
		else
		{
			return 0;
		}
	},

	function getLastContractTimeDelay( _faction )
	{
		// Contract Overhaul Phase 1
		// For Phase 1, we will overhaul the system for Settlement contracts only
		if (_faction.getType() == this.Const.FactionType.Settlement)
		{
			return ::Math.rand(1,2) * ::World.getTime().SecondsPerDay;
		}
		else
		{
			return 0;
		}
	}

};