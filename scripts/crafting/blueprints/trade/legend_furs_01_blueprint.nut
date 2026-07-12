this.legend_furs_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_furs_01";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/trade/furs_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/werewolf_pelt_item",
				Num = 3
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendLeatherworking)]);
	}

	function onCraft(_stash) {
		_stash.add(this.new("scripts/items/trade/furs_item"));
	}

});
