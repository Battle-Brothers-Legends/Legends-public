::mods_hookExactClass("crafting/blueprints/schrat_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.PreviewCraftable = this.new("scripts/items/shields/special/legend_craftable_schrat_shield");
		this.m.Cost = 650;
		this.m.Type = this.Const.Items.ItemType.Shield;
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_woodworking"]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/shields/special/legend_craftable_schrat_shield"));
	}
});
