::mods_hookExactClass("factions/contracts/hunting_lindwurms_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.hunting_lindwurms_contract))
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (::Math.rand(1, 100) > 10)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (!this.isKindOf(village, "legends_steppe_village") && !this.isKindOf(village, "legends_farming_village") && !this.isKindOf(village, "small_steppe_village") && !this.isKindOf(village, "medium_steppe_village") && !this.isKindOf(village, "large_steppe_village") && !this.isKindOf(village, "small_farming_village") && !this.isKindOf(village, "medium_farming_village") && !this.isKindOf(village, "large_farming_village"))
		{
			return;
		}

		this.m.Score = 1;
	}
});
