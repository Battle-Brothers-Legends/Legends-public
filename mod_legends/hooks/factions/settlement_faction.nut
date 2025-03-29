::mods_hookExactClass("factions/settlement_faction", function(o) 
{
	// Contract Overhaul: This is the vanilla method that we have overloaded. It will be deprecated
	// function isReadyForContract()
	// {
	// 	if (this.m.Settlements.len() == 0)
	// 	{
	// 		return false;
	// 	}

	// 	this.m.MaxConcurrentContracts = this.getSettlements()[0].getSize();
	// 	local delay = 5.0 - (this.getSettlements()[0].getSize() - 1);
	// 	return this.m.Contracts.len() < this.m.MaxConcurrentContracts && (this.m.LastContractTime == 0 || this.World.getTime().Days <= 1 || this.Time.getVirtualTimeF() > this.m.LastContractTime + this.World.getTime().SecondsPerDay * delay);
	// }

	// Contract Overhaul: This is the overloaded method we have added. We now take the contract's Category into account
	// Logging Caution: this method gets called a lot, and excessive logging can crash the game. Recommend that the Debug flag for ContractCategoriesVerbose should always be false
	o.isReadyForContract = function ( _category = null )
	{

		if (this.m.Settlements.len() == 0)
		{
			return false;
		}

		local tier = this.getSettlements()[0].getSize() - 1;		
		if ( _category == null || !(_category in this.Const.Contracts.CategoryLimits))
		{
			// if (::Legends.Mod.Debug.isEnabled(::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose))
			// {
			// 	// First give a warning if the Category is null or unrecognised
			// 	local warning = "Contract Overhaul: Category={" + _category + "} is null or unrecognised"
			// 	::Legends.Mod.Debug.printWarning(warning,::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose);	
			// }

			// If there's no Category (e.g. a contract from a submod, or something we missed) or if the Category is not recognised, then only check if there is enough room in the Wildcard slot
			if(this.m.ContractsByCategory["Wildcard"].len() >= this.Const.Contracts.CategoryLimits["Wildcard"][tier])
			{
				// if (::Legends.Mod.Debug.isEnabled(::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose))
				// {
				// 	local warning = "";
				// 	warning += "Contract Overhaul: Check isReadyForContract(" + _category + ") for settlement: " + this.getSettlements()[0].getName() + " (size=" + this.getSettlements()[0].getSize() + ")";
				// 	warning += " --> no Category was given or the Category is not recognised, and the Wildcard slots were full (" + this.m.ContractsByCategory["Wildcard"].len() + " existing contracts)";
				// 	::Legends.Mod.Debug.printWarning(warning,::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose);
				// }
				
				return false;
			}
		}
		else
		{
			// There's no room for new contracts if BOTH the contract's potential corresponding Category slots AND the settlement's Wildcard slots are full
			if (this.m.ContractsByCategory[_category].len() >= this.Const.Contracts.CategoryLimits[_category][tier] && this.m.ContractsByCategory["Wildcard"].len() >= this.Const.Contracts.CategoryLimits["Wildcard"][tier])
			{
				// if (::Legends.Mod.Debug.isEnabled(::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose))
				// {
				// 	local warning = "";
				// 	warning += "Contract Overhaul: Check isReadyForContract(" + _category + ") for settlement: " + this.getSettlements()[0].getName() + " (size=" + this.getSettlements()[0].getSize() + ")";
				// 	warning += " --> both Category and Wildcard slots were full (" + this.m.ContractsByCategory[_category].len() + "," + this.m.ContractsByCategory["Wildcard"].len() + " existing contracts)";
				// 	::Legends.Mod.Debug.printWarning(warning,::Const.LegendMod.Debug.Flags.ContractCategoriesVerbose);
				// }
				
				return false;
			}
		}

		// The remaining checks are based on time-related cooldowns
		local streak = ::Const.LegendMod.ContractCooldown.getStreak(this); // increase cooldown the more the player consecutively takes contracts from the same settlement
		return this.m.LastContractTime == 0 || this.World.getTime().Days <= 1 || this.Time.getVirtualTimeF() > this.m.LastContractTime + this.World.getTime().SecondsPerDay * streak;
			
	}
});