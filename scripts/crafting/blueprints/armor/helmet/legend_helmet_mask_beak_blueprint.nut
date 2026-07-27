this.legend_helmet_mask_beak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_helmet_mask_beak";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/top/legend_helmet_mask_beak");
		this.m.Cost = 110;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_mistletoe_item",
				Num = 2
			}
		];
		this.init(ingredients);
		this.initSkills([
			::Legends.Professions.new(::Legends.Profession.LegendLeatherworking),
			::Legends.Perks.new(::Legends.Perk.LegendMedPackages)
		]);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/legend_helmets/top/legend_helmet_mask_beak");
		_stash.add(item);
	}
});
