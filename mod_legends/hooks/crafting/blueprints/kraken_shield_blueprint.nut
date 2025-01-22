::mods_hookExactClass("crafting/blueprints/kraken_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		local preview = this.new("scripts/items/shields/special/legend_craftable_kraken_shield");
		preview.resetStats();
		this.m.PreviewCraftable = preview;
		this.m.Cost = 1100;
		this.m.Type = this.Const.Items.ItemType.Shield;
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/shields/special/legend_craftable_kraken_shield"));
	}
});
