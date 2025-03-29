::mods_hookExactClass("crafting/blueprints/bone_platings_upgrade2_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade");
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade"));
	}
});
