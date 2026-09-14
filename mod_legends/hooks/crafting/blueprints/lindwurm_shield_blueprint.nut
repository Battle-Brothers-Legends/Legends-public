::mods_hookExactClass("crafting/blueprints/lindwurm_shield_blueprint", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Type = this.Const.Items.ItemType.Shield;
		local preview = ::new("scripts/items/shields/named/named_lindwurm_shield");
		preview.resetStats();
		preview.setName("Lindwurm Shield");
		this.m.PreviewCraftable = preview;
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendLeatherworking)]);
	}

	o.onCraft = function ( _stash )
	{
		_stash.add(::new("scripts/items/shields/named/named_lindwurm_shield"));
	}
});
