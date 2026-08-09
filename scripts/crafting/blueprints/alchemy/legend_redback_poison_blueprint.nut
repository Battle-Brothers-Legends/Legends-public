this.legend_redback_poison_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_redback_poison";
		this.m.Type = ::Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_redback_poison_item");
		this.m.Cost = 375;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_redback_poison_gland_item",
				Num = 2
			}
		];
		this.init(ingredients);
		this.initSkills([
			::Legends.Professions.new(::Legends.Profession.LegendAlchemy)
		]);
	}

	function onCraft(_stash) {
		_stash.add(this.new("scripts/items/accessory/legend_redback_poison_item"));
	}

});
