this.legend_quiver_of_broad_arrows_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_quiver_of_broad_arrows";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/ammo/legend_broad_head_arrows");
		this.m.Cost = 130;
		local ingredients = [
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Backgrounds.new(::Legends.Background.Bowyer)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/ammo/legend_broad_head_arrows"));

	}

});

