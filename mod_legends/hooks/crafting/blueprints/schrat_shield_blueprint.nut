::mods_hookExactClass("crafting/blueprints/schrat_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		local preview = this.new("scripts/items/shields/special/legend_craftable_schrat_shield");
		preview.resetStats();
		this.m.PreviewCraftable = preview;
		this.m.Cost = 650;
		this.m.Type = this.Const.Items.ItemType.Shield;
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendWoodworking)
		];
		this.initSkills(skills);
	}

	o.onCraft <- function ( _stash )
	{
		_stash.add(this.new("scripts/items/shields/special/legend_craftable_schrat_shield"));
	}
});
