this.legend_pauldrons_kraken_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_pauldrons_kraken";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_pauldrons_kraken");
		this.m.Cost = 1000;
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
		_stash.add(::new("scripts/items/legend_armor/armor_upgrades/legend_armor_pauldrons_kraken"));
	}
});
