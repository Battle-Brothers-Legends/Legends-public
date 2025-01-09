this.legend_bandage_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_bandage_blueprint";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/bandage_item");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendMedIngredients)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
		_stash.add(this.new("scripts/items/accessory/bandage_item"));
	}

});

