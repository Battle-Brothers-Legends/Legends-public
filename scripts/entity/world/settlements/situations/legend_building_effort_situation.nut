this.legend_building_effort_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {
		Target = ""
	},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_building_effort";
		this.m.Name = "Building Effort";
		this.m.Description = "This settlement is expanding with a new location, building materials are in high demand and low supply.";
		this.m.Icon = "ui/settlement_status/building_effort_effect.png";
		this.m.Rumors = [
			"Been seein\' lots of materials coming through \'ere to the %direction%...",
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
	}

	function getDescription()
	{
		if (this.m.Target != "")
		{
			return "In an effort to build the new " + this.m.Target.tolower() + ", building materials are in high demand and low supply.";
		}
		else
		{
			return this.m.Description;
		}
	}

	function isValid()
	{
		if (this.m.Target == "")
		{
			return false;
		}

		return this.situation.isValid();
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();

		local a = _settlement.buildNewLocation();

		if (a == null)
		{
			_settlement.removeSituationByID("situation.legend_building_effort");
			return;
		}

		a.setNew(true);
		a.setActive(false);

		this.m.Target = a.getRealName();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 1.5;
		_modifiers.BuildingRarityMult *= 0.5;
	}

	function onRemoved( _settlement )
	{
		foreach( a in _settlement.getAttachedLocations() )
		{
			if (!a.isBuilding())
			{
				continue;
			}

			_settlement.setResources(_settlement.getResources() - 50);
			a.setNew(false);
			a.setActive(true);
			break;
		}
	}

	function onSerialize( _out )
	{
		this.situation.onSerialize(_out);
		_out.writeString(this.m.Target);
	}

	function onDeserialize( _in )
	{
		this.situation.onDeserialize(_in);
		this.m.Target = _in.readString();
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

	}

});

