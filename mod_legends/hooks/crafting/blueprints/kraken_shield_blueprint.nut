::mods_hookExactClass("crafting/blueprints/kraken_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.PreviewCraftable = this.new("scripts/items/shields/special/legend_craftable_kraken_shield");
		this.m.Cost = 1100;
		this.m.Type = this.Const.Items.ItemType.Shield;
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/shields/special/legend_craftable_kraken_shield"));
	}
});
