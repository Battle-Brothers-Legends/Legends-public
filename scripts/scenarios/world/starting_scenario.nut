this.starting_scenario <- {
	m = {
		ID = "",
		Name = "",
		Description = "",
		Difficulty = 1,
		Order = 0,
		IsFixedLook = false,
		CurrentSettlement = null,
		StashModifier = 0,
		StartingBusinessReputation = 0,
		StartingRosterTier = this.Const.Roster.DefaultTier,
		RosterTierMax = this.Const.Roster.DefaultTierMax,
		RosterTierMaxCombat = null,
		RosterReputationTiers = this.Const.Roster.DefaultReputationTiers,
		StaticRelationsToFaction = array(this.Const.FactionType.len(), false) 	//Something defined here won't have relations normalized over time in faction_manager
										//I think this would be better if we instead automatically set the size to be
	}									//equal to length of factiontypes and then we can skip if len() > 0 in
										//faction_manager's update()
	function isFixedLook()				//Useful for when you set the relations and want them to be permanent e.g. legion scenario
	{
		return this.m.IsFixedLook;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getDifficulty()
	{
		return this.m.Difficulty;
	}

	function getOrder()
	{
		return this.m.Order;
	}

	function isFixedLook()
	{
		return this.m.IsFixedLook;
	}

	function isDroppedAsLoot( _item )
	{
		local chanceIsLucky = 0;
		local brothers = this.World.getPlayerRoster().getAll();
		foreach (bro in brothers)
		{
			if (bro.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendScholar))
			{
				chanceIsLucky += 10;
			}
			if (bro.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan))
			{
				chanceIsLucky += 5;
			}
		}
		return this.Math.rand(1, 100) < chanceIsLucky;
	}

	function getDifficultyForUI()
	{
		switch(this.m.Difficulty)
		{
		case 1:
			return "difficulty_easy";

		case 2:
			return "difficulty_medium";

		case 3:
			return "difficulty_hard";

		case 4:
			return "difficulty_legend";
		}

		return "difficulty_unknown";
	}

	function getOrder()
	{
		return this.m.Order;
	}

	function getStaticRelations()
	{
		return this.m.StaticRelationsToFaction;
	}

	function getStashModifier()
	{
		return this.m.StashModifier;
	}

	function isValid()
	{
		return true;
	}

	function onSpawnAssets()
	{
	}

	function onSpawnPlayer()
	{
	}

	function onInit()
	{
		this.m.StaticRelationsToFaction.resize(this.Const.FactionType.len());

		if (this.World.State.getPlayer() != null)
			this.World.State.getPlayer().calculateModifiers();
	}

	function onUpdateHiringRoster( _roster )
	{
	}

	function onUpdateDraftList( _list )
	{
	}

	function onUpdateStablesList( _list )
	{
	}

	function onHiredByScenario( _bro )
	{
	}

	function onBuildPerkTree( _background )
	{
	}

	function onHired( _bro )
	{
	}

	function onActorKilled( _actor, _killer, _combatID )
	{
	}

	function onBattleWon( _combatLoot )
	{
	}

	function onCombatFinished()
	{
		return true;
	}

	function onContractFinished( _contractType, _cancelled )
	{
	}

	function onUnlockPerk( _bro, _perkID )
	{
	}

	function onUpdateLevel( _bro )
	{
	}

	function onGetBackgroundTooltip( _background, _tooltip )
	{
	}

	function getStartingRosterTier()
	{
		return this.m.StartingRosterTier;
	}

	function getRosterTier()
	{
		return this.Math.min(this.getRosterTierMax(), this.getRosterTierFromReputation() + this.getStartingRosterTier());
	}

	function getRosterTierCombat()
	{
		local tierMax = this.m.RosterTierMaxCombat == null ? this.Math.min(this.getRosterTierMax(), this.m.RosterTierMaxCombat) : this.m.RosterTierMaxCombat;
		return this.Math.min(tierMax, this.getRosterTierFromReputation() + this.getStartingRosterTier());
	}

	function getRosterTierMax()
	{
		return this.m.RosterTierMax;
	}

	function getRosterTierFromReputation()
	{
		local tier = 0;

		for( local i = 0; i < this.m.RosterReputationTiers.len(); i++ )
		{
			if (this.World.Assets.getBusinessReputation() >= this.m.RosterReputationTiers[i])
			{
				tier++;
			}
		}

		return tier;
	}

	function getRosterReputationTiers()
	{
		return this.m.RosterReputationTiers;
	}

	function setRosterReputationTiers( _tiers )
	{
		this.m.RosterReputationTiers = _tiers;
	}

	function addScenarioPerk( _background, _perk, _row = 0, _addSkill = true )
	{
		if (_background.m.CustomPerkTree == null)
		{
			return;
		}

		local isRefundable = true;

		if (_addSkill && _background.getContainer() != null)
		{
			_background.getContainer().add(this.new(this.Const.Perks.PerkDefObjects[_perk].Script));
			isRefundable = false;
		}

		_background.addPerk(_perk, _row, isRefundable);
		if (!isRefundable) _background.getPerk(_perk).IsRefundable = false;
	}

	function onGenerateBro(_bro)
	{
	}

	function addBroToRoster(_roster, _background, _chance)
	{
		local multiplier = _roster.getAll().len() < 8 ? 2 : 1; // Short little change to make these spawns less common in tiny villages

		if (::Math.rand(0, _chance * multiplier) == 0) {
			local bro = _roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx([_background]);
			//this.World.Assets.getOrigin().onGenerateBro(bro); will be called at the end of `updateRoster` in `settlement` anyway
		}
	}

	function getCurrentSettlement()
	{
		return this.m.CurrentSettlement;
	}

	function setCurrentSettlement( _settlement )
	{
		this.m.CurrentSettlement = ::MSU.asWeakTableRef(_settlement);
	}

};
