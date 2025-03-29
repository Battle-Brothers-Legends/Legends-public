this.legend_cloak_heavy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		Variants = 0,
		Variant = 1
	},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_cloak_heavy_blueprint";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/cloak/legend_armor_cloak_heavy");
		this.m.Variants = this.m.PreviewCraftable.m.Variants.len();
		this.m.PreviewCraftable.setVariant(this.m.PreviewCraftable.m.Variants[0]);
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 2
			},
			{
				Script = "scripts/items/trade/furs_item",
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
		local item = this.new("scripts/items/legend_armor/cloak/legend_armor_cloak_heavy");
		item.setVariant(item.m.Variants[this.m.Variant-1]);
		_stash.add(item);
	}

	function setVariant( _variant )
	{
		this.m.Variant = _variant;
	}
});

