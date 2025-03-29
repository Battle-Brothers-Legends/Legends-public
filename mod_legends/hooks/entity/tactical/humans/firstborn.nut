::mods_hookExactClass("entity/tactical/humans/firstborn", function(o) 
{
	o.getPlaceInFormation = function ()
	{
		return 26;
	}

	o.assignRandomEquipment = function ()
	{

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"],
			[3, ""]
		]))
	}
});