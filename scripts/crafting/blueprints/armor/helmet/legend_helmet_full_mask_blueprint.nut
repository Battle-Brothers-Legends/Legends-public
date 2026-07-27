this.legend_helmet_full_mask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_helmet_full_mask";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/hood/legend_helmet_full_mask");
		this.m.Cost = 85;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			}
		];
		this.init(ingredients);
		this.initSkills([
			::Legends.Professions.new(::Legends.Profession.LegendTailoring),
			::Legends.Perks.new(::Legends.Perk.LegendMedIngredients)
		]);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_helmets/hood/legend_helmet_full_mask");
		_stash.add(item);
	}
});
