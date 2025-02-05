this.large_quiver_of_broad_bolts_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.large_quiver_of_broad_bolts";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/ammo/legend_large_broad_head_bolts");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/misc/ancient_wood_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/bowyer_background"]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/ammo/legend_large_broad_head_bolts"));

	}

});

