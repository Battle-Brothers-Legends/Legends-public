this.legend_militant_townsfolk_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_militant_townsfolk";
		this.m.Name = "Militant Townsfolk";
		this.m.Description = "The local townsfolk have had enough of the constant attacks on their village. They are setting aside their livelihoods, turning their tools into weapons, and banding together to fight back.";
		this.m.Icon = "ui/perks/pitchfork_02.png";
		this.m.Rumors = [
			"My sister-in-law in %settlement% told me that they\'ve had enough of being beaten around. They\'re all up in arms now and spoiling for a fight!",
			"If you\'re looking to hire more mercenaries, you should visit %settlement%. I heard many of them are eager to take the fight back to their enemies.",
			"Be careful if you\'re passing through %settlement%. I hear the locals there are ready to go to war against anyone who crosses them!"
		];
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		// This situation can only occur in Tier 1 and Tier 2 settlements (non-fort and non-city-state)
		if ( _settlement.getSize() > 2 || _settlement.isMilitary() || ::MSU.isKindOf(_settlement, "city_state"))
		{
			_settlement.removeSituationByID(this.getID());
			return;
		}

		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.addWorldEconomyResources(-5);
		}
		_settlement.resetRoster(true);
		_settlement.resetShop();

	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.75;
		_modifiers.MineralRarityMult *= 0.25;
		_modifiers.BuildingRarityMult *= 0.25;
		_modifiers.RecruitsMult *= 4;
	}

	function onUpdateShop( _stash )
	{
		// Further improvement: make the items based on attached locations or settlement type
		if ( _stash.getID() == "shop")
		{
			local wc = ::MSU.Class.WeightedContainer([
				[1,"scripts/items/weapons/legend_hoe"],
				[1,"scripts/items/weapons/legend_scythe"],
				[2,"scripts/items/weapons/pitchfork"],
				[2,"scripts/items/weapons/warfork"],
				[1,"scripts/items/weapons/wooden_flail"],
				[1,"scripts/items/weapons/butchers_cleaver"],
				[2,"scripts/items/weapons/legend_militia_glaive"],
				[1,"scripts/items/weapons/militia_spear"],
				[1,"scripts/items/weapons/legend_saw"],
				[1,"scripts/items/weapons/legend_shovel"],
				[1,"scripts/items/weapons/legend_slingshot"],
				[1,"scripts/items/weapons/legend_tipstaff"],
				[2,"scripts/items/weapons/hooked_blade"],
				[1,"scripts/items/weapons/legend_sickle"],
				[1,"scripts/items/weapons/legend_hoe"],
				[1,"scripts/items/weapons/two_handed_wooden_flail"],
				[1,"scripts/items/weapons/woodcutters_axe"],
				[1,"scripts/items/weapons/hatchet"],
			]);

			local amt = ::Math.rand(10,15);
			for (local i=0; i < amt; i++)
			{
				local item = this.new(wc.roll());
				if (item.getConditionMax() > 1)
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						local condition = this.Math.rand(item.getConditionMax() * 0.4, item.getConditionMax() * 0.9);
						item.setCondition(condition);
					}
				}
				_stash.add(item);
			}
		}
	}

	function onUpdateDraftList( _draftList )
	{
		// Future improvement: make the backgrounds dynamic based on attached locations or settlement type
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("miller_background");
		_draftList.push("miller_background");
		_draftList.push("miller_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("shepherd_background");
		_draftList.push("shepherd_background");
		_draftList.push("shepherd_background");
		_draftList.push("tailor_background");
		_draftList.push("tailor_background");
		_draftList.push("apprentice_background");
		_draftList.push("apprentice_background");
	}
});

