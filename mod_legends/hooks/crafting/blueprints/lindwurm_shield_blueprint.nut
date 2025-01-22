::mods_hookExactClass("crafting/blueprints/lindwurm_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Shield;
		local preview = ::new("scripts/items/shields/named/named_lindwurm_shield");
		preview.setName("Lindwurm Shield");
		preview.resetStats();
		this.m.PreviewCraftable = preview;
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_woodworking"]
			}
		];
		this.initSkills(skills);
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(::new("scripts/items/shields/named/named_lindwurm_shield"));
	}
});
