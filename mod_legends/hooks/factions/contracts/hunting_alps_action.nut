::mods_hookExactClass("factions/contracts/hunting_alps_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.hunting_alps_contract))
		{
			return;
		}

		if (this.Math.rand(1, 100) > 5)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 350)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (this.isKindOf(village, "legends_lumber_village") || this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village"))
		{
			return;
		}

		this.m.Score = 1;
	}
});
