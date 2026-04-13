::mods_hookExactClass("crafting/blueprints/hyena_fur_upgrade_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/cloak/legend_hyena_fur_cloak");
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/cloak/legend_hyena_fur_cloak"));
	}
});
