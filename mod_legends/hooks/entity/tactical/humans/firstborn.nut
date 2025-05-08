::mods_hookExactClass("entity/tactical/humans/firstborn", function(o)
{
	o.getPlaceInFormation = function ()
	{
		return 26;
	}

	o.assignRandomEquipment = function ()
	{

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[3, ::Legends.Helmet.None]
		]))
	}
});
