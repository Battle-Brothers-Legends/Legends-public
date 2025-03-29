this.legend_cloak_noble_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		Variants = 0,
		Variant = 1
	},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_cloak_noble_blueprint";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/cloak/legend_armor_cloak_noble");
		this.m.Variants = this.m.PreviewCraftable.m.Variants.len();
		this.m.PreviewCraftable.setVariant(this.m.PreviewCraftable.m.Variants[0]);
		this.m.Cost = 3000;
		local ingredients = [
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 6
			},
			{
				Script = "scripts/items/trade/dies_item",
				Num = 4
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
		local item = this.new("scripts/items/legend_armor/cloak/legend_armor_cloak_noble");
		item.setVariant(item.m.Variants[this.m.Variant-1]);
		_stash.add(item);
	}

	function setVariant( _variant )
	{
		this.m.Variant = _variant;
	}
});

