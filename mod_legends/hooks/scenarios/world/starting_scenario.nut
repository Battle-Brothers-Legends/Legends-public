::mods_hookBaseClass("scenarios/world/starting_scenario", function (o) {
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.m.CurrentSettlement <- null;
	o.m.StashModifier <- 0;
	o.m.StartingBusinessReputation <- 0;
	o.m.StartingRosterTier <- this.Const.Roster.DefaultTier;
	o.m.RosterTierMax <- this.Const.Roster.DefaultTierMax;
	o.m.RosterTierMaxCombat <- null;
	o.m.RosterReputationTiers <- this.Const.Roster.DefaultReputationTiers;
	o.m.StaticRelationsToFaction <- array(this.Const.FactionType.len(), false);
	//Something defined here won't have relations normalized over time in faction_manager
	//I think this would be better if we instead automatically set the size to be faction_manager's update()
	//Useful for when you set the relations and want them to be permanent e.g. legion scenario

	o.isDroppedAsLoot = function (_item)
	{
		local chanceIsLucky = 0;
		local brothers = ::World.getPlayerRoster().getAll();
		foreach (bro in brothers)
		{
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
				chanceIsLucky += 10;

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendFavouredEnemyCaravan))
				chanceIsLucky += 5;
		}
		return ::Math.rand(1, 100) < chanceIsLucky;
	}

	local getDifficultyForUI = o.getDifficultyForUI;
	o.getDifficultyForUI = function ()
	{
		if (this.m.Difficulty == 4)
			return "difficulty_legend";
		return getDifficultyForUI();
	}

	o.getStaticRelations <- function ()
	{
		return this.m.StaticRelationsToFaction;
	}

	o.getStashModifier <- function()
	{
		return this.m.StashModifier;
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.StaticRelationsToFaction.resize(::Const.FactionType.len());
	}

	o.onUpdateStablesList <- function ( _list )
	{
	}

	o.onHiredByScenario <- function ( _bro )
	{
	}

	o.onBuildPerkTree <- function ( _background )
	{
	}


	o.getStartingRosterTier <- function ()
	{
		return this.m.StartingRosterTier;
	}

	o.getRosterTier <- function ()
	{
		return ::Math.min(this.getRosterTierMax(), this.getRosterTierFromReputation() + this.getStartingRosterTier());
	}

	o.getRosterTierCombat <- function ()
	{
		local tierMax = this.m.RosterTierMaxCombat == null ? ::Math.min(this.getRosterTierMax(), this.m.RosterTierMaxCombat) : this.m.RosterTierMaxCombat;
		return ::Math.min(tierMax, this.getRosterTierFromReputation() + this.getStartingRosterTier());
	}

	o.getRosterTierMax <- function ()
	{
		return this.m.RosterTierMax;
	}

	o.getRosterTierFromReputation <- function ()
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

	o.getRosterReputationTiers <- function ()
	{
		return this.m.RosterReputationTiers;
	}

	o.setRosterReputationTiers <- function ( _tiers )
	{
		this.m.RosterReputationTiers = _tiers;
	}

	o.addScenarioPerk <- function ( _background, _perk, _row = 0, _addSkill = true )
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

	o.onGenerateBro <- function (_bro)
	{
	}

	o.addBroToRoster <- function (_roster, _background, _chance)
	{
		local multiplier = _roster.getAll().len() < 8 ? 2 : 1; // Short little change to make these spawns less common in tiny villages

		if (::Math.rand(0, _chance * multiplier) == 0) {
			local bro = _roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx([_background]);
			//this.World.Assets.getOrigin().onGenerateBro(bro); will be called at the end of `updateRoster` in `settlement` anyway
		}
	}

	o.getCurrentSettlement <- function ()
	{
		return this.m.CurrentSettlement;
	}

	o.setCurrentSettlement <- function ( _settlement )
	{
		this.m.CurrentSettlement = ::MSU.asWeakTableRef(_settlement);
	}
});
