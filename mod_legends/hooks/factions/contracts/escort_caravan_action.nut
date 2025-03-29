::mods_hookExactClass("factions/contracts/escort_caravan_action", function(o)
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _faction )
	{
		// For settlement faction
		if (_faction.getType()==this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.escort_caravan_contract))
		{
			return;
		}

		onUpdate(_faction);
	}
});
