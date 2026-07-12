this.legend_horn_plate_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_horn_plate";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = ::new("scripts/items/legend_armor/plate/legend_armor_horn_plate_named");
		preview.m.Name = "Kraken Horn Plate";
		this.m.PreviewCraftable = preview;
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/misc/kraken_horn_plate_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 2
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendMetalworking)]);
	}

	function onCraft(_stash) {
		_stash.add(::new("scripts/items/legend_armor/plate/legend_armor_horn_plate_named"));
	}
});
