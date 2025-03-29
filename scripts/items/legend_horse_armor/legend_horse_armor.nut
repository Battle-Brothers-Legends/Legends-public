this.legend_horse_armor <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		// this.m.ItemType = this.Const.Items.ItemType.HorseArmor;
	}

	function onSerialize( _out )
	{
		this.legend_armor.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.legend_armor.onDeserialize(_in);
	}

});

