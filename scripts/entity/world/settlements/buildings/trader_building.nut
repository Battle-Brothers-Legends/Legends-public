this.trader_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {},
	function create()
	{
		this.building.create();
		this.m.ID = "building.trader";
		this.m.Name = "Trader";
		this.m.UIImage = "ui/settlements/building_08";
		this.m.UIImageNight = "ui/settlements/building_08_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Trader";
	}

	function onClicked( _townScreen )
	{
	}

	function onSettlementEntered()
	{
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);
	}

});

