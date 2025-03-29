if (!("HuntingLoot" in ::Const))
{
	::Const.HuntingLoot <- {};
}

::Const.HuntingLoot <- {

	function getGenerator( _biome, _upgraded, _huntLevel, _cookLevel, _brewLevel, _partyBackgrounds = null, _mode = 0)
	{
		local generator = {
			
			Target = ::MSU.Class.WeightedContainer(null),
			Brew = ::MSU.Class.WeightedContainer(null),
			HuntLevel = _huntLevel,
			CookLevel = _cookLevel,
			BrewLevel = _brewLevel,
			Upgraded = _upgraded,
			Mode = _mode,

			function dropLoot(_level, _withModeBonus=false)
			{
				local upgradeModifier = this.Upgraded ? 1.15 : 1.0;
				local modeBonus = _withModeBonus ? 2.0 : 1.0;
				// Without the upgradeModifier or modeBonus: At level 10 there is a 5% chance per hour, increases asymptotically to 15% per hour
				return ::Math.rand(1,100) < ((-300.0 / (_level + 20) + 15) * upgradeModifier) * modeBonus;
			},

			function rollTarget()
			{
				local targetDef = this.Target.roll();

				local food = this.new(targetDef.Food);
				local loot = null;
				local cook = null;
				local isHuntMode = false;
				local isCookMode = false;
				local huntModeBonus = 1;
				local cookModeBonus = 1;
				local modeDifficultyMultiplier = 1;

				// Check for Mode bonuses
				if (this.Mode == ::Const.HuntingLoot.HunterCampMode.Hunt)
				{
					isHuntMode = true;
					huntModeBonus = 2;
					modeDifficultyMultiplier = 2;
				}
				else if (this.Mode == ::Const.HuntingLoot.HunterCampMode.Cook)
				{
					isCookMode = true;
					cookModeBonus = 2;
					modeDifficultyMultiplier = 2;
				}
				else if (this.Mode == ::Const.HuntingLoot.HunterCampMode.Brew)
				{
					modeDifficultyMultiplier = 2;
				}
				else if (this.Mode == ::Const.HuntingLoot.HunterCampMode.Forage)
				{
					modeDifficultyMultiplier = 0.75;
				}

				if(targetDef.Type=="Hunt" && this.Upgraded && this.HuntLevel > 0 && (::Math.rand(1,5) <= (2 * huntModeBonus) || this.dropLoot(this.HuntLevel, isHuntMode)))
				{
					loot = this.new(::MSU.Class.WeightedContainer(targetDef.Loot).roll());
				}

				if("Cook" in targetDef && this.CookLevel > 0 && (::Math.rand(1,5) <= (2 * cookModeBonus) || this.dropLoot(this.CookLevel, isCookMode)))
				{
					cook = this.new(targetDef.Cook)
				}

				local res = {
					Name = targetDef.Name,
					Text = targetDef.Text,
					Type = targetDef.Type,
					Difficulty = targetDef.Difficulty * modeDifficultyMultiplier,
					Food = food,
					Loot = loot,
					Cook = cook,
				}

				return res;
			}

			function rollBrew()
			{
				if( this.dropLoot(this.BrewLevel, this.Mode == ::Const.HuntingLoot.HunterCampMode.Brew) )
				{
					return this.new(this.Brew.roll());
				}
				else
				{
					return false;
				}
			}

			function getEligibleTargets()
			{
				return this.Target.toArray(true);
			}

		};

		local biomeRewards = this.getBiomeRewards(_biome);

		// Add potential targets based on the biome
		// (only targets whose requirements are met)
		foreach (targetContainer in biomeRewards[0])
		{
			local target = targetContainer[1];
			// Check if the hunting party meets the required Tier, if applicable
			if (!this.hasSufficientHuntLevelForTier(target, _huntLevel))
			{
				continue;
			}

			// Check if the hunting party meets any background requirements, if applicable
			if ("Backgrounds" in target && !this.hasQualifiedBackground(target.Backgrounds, _partyBackgrounds))
			{
				continue;
			}

			// Hunt mode: ignore all Forage targets
			if (_mode == ::Const.HuntingLoot.HunterCampMode.Hunt && target.Type=="Forage")
			{
				continue;
			}

			// Forage mode: ignore all Hunt targets
			if (_mode == ::Const.HuntingLoot.HunterCampMode.Forage && target.Type=="Hunt")
			{
				continue
			}

			generator.Target.addArray([targetContainer])
		}

		generator.Brew.addArray(biomeRewards[1]);
		if (_upgraded) generator.Brew.addArray([[1, "scripts/items/supplies/mead_item"]]); // default behaviour until further rework

		return generator;
	},

	function getHuntLevelTier( _huntLevel )
	{
		if ( _huntLevel == 0 )
		{
			return 0;
		}
		else if ( _huntLevel <= 7 )
		{
			return 1;
		}
		else if ( _huntLevel <= 14 )
		{
			return 2;
		}
		else
		{
			return 3;
		}
	}

	function getBiomeRewards( _biome )
	{
		local biomeRewards = ::Const.HuntingLoot.Biomes[_biome];

		// Generic rewards just in case the biome isn't suppported
		if(!biomeRewards || biomeRewards[0].len()==0) 
		{
			return ::Const.HuntingLoot.BiomesDefault;
		}
		else
		{
			return biomeRewards;	
		}
	}

	function getBiomeTargetDefs( _biome )
	{
		local ret = [];
		local biomeRewards = this.getBiomeRewards(_biome);
		foreach (targetContainer in biomeRewards[0])
		{
			local target = targetContainer[1];
			ret.push(target);
		}

		return ret;
	}

	function hasSufficientHuntLevelForTier( _target, _huntLevel )
	{
		if ("Tier" in _target)
		{
			return this.getHuntLevelTier(_huntLevel) >= _target.Tier;	
		}
		else 
		{
			return true;
		}
	}

	function hasQualifiedBackground( _requiredBackgrounds, _partyBackgrounds)
	{
		if ( _partyBackgrounds == null || _partyBackgrounds.len()==0 )
		{
			return false;
		}

		foreach (bg in _requiredBackgrounds)
		{
			if (_partyBackgrounds.find(bg) != null)
			{
				return true;
			}
		}
		return false;
	}

};

::Const.HuntingLoot.HunterCampMode <- {
	Default = 0,
	Cook = 1,
	Brew = 2,
	Hunt = 3,
	Forage = 4,
}; // Tooltips are defined in CampingHuntingMode in legends_msu_tooltips.nut

::Const.HuntingLoot.HunterCampModeNameMap <- array(::Const.HuntingLoot.HunterCampMode.len(),null);
foreach (k, v in ::Const.HuntingLoot.HunterCampMode)
{
	::Const.HuntingLoot.HunterCampModeNameMap[v] = k;
}