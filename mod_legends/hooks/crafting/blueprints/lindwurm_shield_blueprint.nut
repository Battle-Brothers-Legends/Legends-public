::mods_hookExactClass("crafting/blueprints/lindwurm_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Shield;
		this.m.PreviewCraftable = this.new("scripts/items/shields/named/named_lindwurm_shield");
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_woodworking"]
			}
		];
		this.initSkills(skills);
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(this.new("scripts/items/shields/named/named_lindwurm_shield"));
	}
});
