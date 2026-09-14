::mods_hookExactClass("crafting/blueprints/large_quiver_of_arrows_blueprint", function (o) {
	o.create = function () {
		this.blueprint.create();
		this.m.ID = "blueprint.large_quiver_of_arrows";
		this.m.Type = ::Const.Items.ItemType.Ammo;
		this.m.PreviewCraftable = ::new("scripts/items/ammo/large_quiver_of_arrows");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/misc/ancient_wood_item",
				Num = 1
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendWoodworking)]);
	}

	o.onCraft = function (_stash) {
		_stash.add(::new("scripts/items/ammo/large_quiver_of_arrows"));
	}
});
