this.legend_horse_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		// this.m.ItemType = this.Const.Items.ItemType.HorseHelmet;
	}

	function onSerialize( _out )
	{
		this.helmet.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.helmet.onDeserialize(_in);
	}

});

