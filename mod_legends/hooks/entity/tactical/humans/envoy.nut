::mods_hookExactClass("entity/tactical/humans/envoy", function(o)
{
	o.getPlaceInFormation = function() {
		return this.m.PlaceInFormation;
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[2, ::Legends.Helmet.None]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
