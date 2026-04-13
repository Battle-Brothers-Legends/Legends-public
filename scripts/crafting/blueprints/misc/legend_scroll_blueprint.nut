this.legend_scroll_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_experience_scroll_blueprint";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/legend_scroll_preview_item");
		this.m.Cost = 2000;
		// this.m.Cost = 10;
		local ingredients = [{
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
			::Legends.Perks.blueprint(::Legends.Perk.LegendScrollIngredients)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash ) {
		_stash.add(this.new("scripts/items/misc/legend_scroll_item"));
	}

});
