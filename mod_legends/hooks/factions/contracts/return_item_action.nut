::mods_hookExactClass("factions/contracts/return_item_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.return_item_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolatedFromRoads())
		{
			return;
		}

		if (this.World.getTime().Days >= 20 && this.Math.rand(1, 100) > 9)
		{
			return;
		}

		this.m.Score = 1;
	}
});
