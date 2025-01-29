this.legend_upgrading_locations_effort_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_upgrading_locations_effort";
		this.m.Name = "Upgrading Max Locations Effort";
		this.m.Description = "This settlement is in the process of upgrading, building materials are in high demand and low supply.";
		this.m.Icon = "ui/settlement_status/upgrading_locations_effect.png";
		this.m.Rumors = [
			"Been seein\' lots of materials coming through \'ere to the %direction%...",
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 10;
	}

	function getDescription()
	{
		return "In an effort to expand and upgrade the settlement, building materials are in high demand and low supply.";
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.setUpgrading(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 2.0;
		_modifiers.BuildingRarityMult *= 0.75;
	}

	function onRemoved( _settlement )
	{
		_settlement.setResources(_settlement.getResources() - 50);
		_settlement.m.AttachedLocationsMax + 1;
	}

	function onUpdateDraftList( _draftList )
	{
		if (this.m.IsSouthern) {
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
		}
		else {
			_draftList.push("lumberjack_background");
			_draftList.push("lumberjack_background");
			_draftList.push("mason_background");
			_draftList.push("mason_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("legend_inventor_background");
		}

		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
	}

});

