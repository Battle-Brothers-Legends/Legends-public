::mods_hookExactClass("entity/tactical/enemies/unhold_armored", function(o)
{
	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/armor/barbarians/unhold_armor_light"));
		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.unhold_helmet_light]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
