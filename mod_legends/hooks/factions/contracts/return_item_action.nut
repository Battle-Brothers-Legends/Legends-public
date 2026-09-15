::mods_hookExactClass("factions/contracts/return_item_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.return_item_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolatedFromRoads())
		{
			return;
		}

		if (::World.getTime().Days >= 20 && ::Math.rand(1, 100) > 9)
		{
			return;
		}

		this.m.Score = 1;
	}
});
