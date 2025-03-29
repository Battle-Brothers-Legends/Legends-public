this.legend_tabard_noble_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
	},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_tabard_noble_blueprint";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/tabard/legend_noble_tabard");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/dies_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/tailor_background"]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_armor/tabard/legend_noble_tabard");
		item.setVariant(this.m.PreviewCraftable.m.Variant);
		_stash.add(item);
	}

	// function setVariant( _variant )
	// {
	// 	this.m.Variant = _variant;
	// }
});

