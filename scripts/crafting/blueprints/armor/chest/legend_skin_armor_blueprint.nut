this.legend_skin_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_skin_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = this.new("scripts/items/legend_armor/legendary/legend_skin_armor");
		preview.m.Name = "Skinghoul Armor";
		this.m.PreviewCraftable = preview;
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
				Num = 5
			},
			{
				Script = "scripts/items/misc/legend_masterwork_fabric",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_masterwork_tools",
				Num = 1
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendLeatherworking)]);
	}

	function isQualified() {
		return this.blueprint.isQualified();
	}

	function onCraft(_stash) {
		_stash.add(::new("scripts/items/legend_armor/legendary/legend_skin_armor"));
	}

});
