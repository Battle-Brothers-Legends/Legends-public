::mods_hookExactClass("crafting/blueprints/direwolf_pelt_upgrade_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade");
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
	}
});
