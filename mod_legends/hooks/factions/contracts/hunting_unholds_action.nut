::mods_hookExactClass("factions/contracts/hunting_unholds_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.hunting_unholds_contract))
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 700)
		{
			return;
		}

		if (this.Math.rand(1, 100) > 15)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (this.isKindOf(village, "legends_lumber_village") || this.isKindOf(village, "legends_swamp_village") || this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village") || this.isKindOf(village, "small_swamp_village") || this.isKindOf(village, "medium_swamp_village"))
		{
			this.m.EnemyType = 0;
		}
		else if (this.isKindOf(village, "legends_snow_village") || this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
		{
			this.m.EnemyType = 1;
		}
		else if (this.isKindOf(village, "legends_tundra_village") || this.isKindOf(village, "legends_mining_village") || this.isKindOf(village, "small_tundra_village") || this.isKindOf(village, "medium_tundra_village") || this.isKindOf(village, "small_mining_village"))
		{
			this.m.EnemyType = 2;
		}
		else
		{
			return;
		}

		this.m.Score = 1;
	}
});
