this.legend_greenwood_schrat_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_greenwood_schrat_shield";
		this.m.Type = this.Const.Items.ItemType.Shield;
		this.m.PreviewCraftable = this.new("scripts/items/shields/special/legend_craftable_greenwood_schrat_shield");
		this.m.Cost = 450;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_ancient_green_wood_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/glowing_resin_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_woodworking"]
			}
		];
		this.initSkills(skills);
	}


	function isQualified()
	{
		return this.blueprint.isQualified();
	}
	
	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/shields/special/legend_craftable_greenwood_schrat_shield"));
	}

});

