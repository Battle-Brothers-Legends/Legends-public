this.legend_horse_armor_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create() 
	{
		this.legend_armor_upgrade.create();
		// this.m.ItemType = this.Const.Items.ItemType.HorseArmor;
	}

	function onSerialize( _out )
	{
		this.legend_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.legend_armor_upgrade.onDeserialize(_in);
	}

});