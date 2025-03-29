local blueprints = [
	"heavy_wardog_armor_upgrade_blueprint",
	"wardog_armor_upgrade2_blueprint",
	"wardog_armor_upgrade_blueprint"
];

foreach (blueprint in blueprints)
{
	::mods_hookExactClass("crafting/blueprints/" + blueprint, function(o)
	{
		local create = o.create;
		o.create = function ()
		{
			create();
			this.m.Type = this.Const.Items.ItemType.Usable;
		}
	});
};