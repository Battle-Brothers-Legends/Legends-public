::mods_hookExactClass("factions/contracts/roaming_beasts_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.roaming_beasts_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		// Check contract exclusivity
		if (_faction.hasContractExclusion("contract.roaming_beasts"))
		{
			return;
		}

		if (this.World.getTime().Days <= 3 && this.Math.rand(1, 100) < 20 || this.Math.rand(1, 100) > 10)
		{
			return;
		}

		this.m.Score = 1;
	}
});
