::mods_hookExactClass("factions/contracts/hunting_schrats_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.hunting_schrats_contract))
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (this.Math.rand(1, 100) > 20)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (!this.isKindOf(village, "legends_lumber_village") && !this.isKindOf(village, "small_lumber_village") && !this.isKindOf(village, "medium_lumber_village") && !this.isKindOf(village, "large_lumber_village"))
		{
			return;
		}

		this.m.Score = 1;
	}
});
