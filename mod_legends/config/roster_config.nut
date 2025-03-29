::Const.Roster <- {
	function getSizeForTier( _tier )
	{
		return ::Const.Roster.Size[_tier];
	}

	function getInCombatSizeForTier( _tier )
	{
		return ::Const.Roster.InCombatSize[_tier];
	}

	function getTierForSize( _size )
	{
		foreach (i, size in ::Const.Roster.Size)
		{
			if (size >= _size)
			{
				return ::Const.Roster.Tier[i];
			}
		}
	}

	function getTierForInCombatSize( _size )
	{
		foreach (i, size in ::Const.Roster.InCombatSize)
		{
			if (size >= _size)
			{
				return ::Const.Roster.Tier[i];
			}
		}
	}

	function createReputationTiers( _startingReputation )
	{
		local tiers = [];

		foreach (rep in ::Const.BusinessReputation)
		{
			if (rep > _startingReputation && tiers.len() < ::Const.Roster.Tier.len())
			{
				tiers.push(rep);
			}
		}

		// If Reputation tiers are fewer in number than Roster Tiers, add more Reputation Tiers 
		// with steps of half of the last tier until the two arrays are equal in length
		for (local i = 0; i < ::Const.Roster.Tier.len() - tiers.len(); i++)
		{
			local lastReputation = tiers[tiers.len() - 1];
			tiers.push(lastReputation + lastReputation/2);
		}

		return tiers;
	}
};

::Const.Roster.Tier <- [
	0,
	1,
	2, // Default starting tier
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10
];

::Const.Roster.Size <- [
	1, 
	3,  
	6,  // Default starting size
	8,  
	10, 
	12,
	15, 
	18, 
	21, 
	25, 
	27, 
];

::Const.Roster.InCombatSize <- [
	1,
	3,  
	6,  // Default starting size
	8,  
	10, 
	12, 
	14, 
	16, 
	18,
	20, 
	22, 
];

::Const.Roster.DefaultTierMax <- ::Const.Roster.Tier[::Const.Roster.Tier.len() - 2];
::Const.Roster.DefaultTier <- 2;

::Const.Roster.DefaultReputationTiers <- ::Const.Roster.createReputationTiers(250);

