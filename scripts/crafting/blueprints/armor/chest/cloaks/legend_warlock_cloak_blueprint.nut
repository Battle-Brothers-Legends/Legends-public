this.legend_warlock_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_warlock_cloak";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = this.new("scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak");
		preview.resetStats();
		preview.m.Name = "Warlock Cloak";
		this.m.PreviewCraftable = preview;
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/misc/witch_hair_item",
				Num = 4
			},
			{
				Script = "scripts/items/misc/parched_skin_item",
				Num = 4
			},
			{
				Script = "scripts/items/spawns/legend_zombie_item",
				Num = 1
			}
		];
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_tunic",
			Num = 1,
			LegendsArmor = true
		});
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/tailor_background"]
			}
		];
		this.initSkills(skills);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local item;
		item = this.new("scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak");
		item.m.Name = "";
		_stash.add(item);
	}

});

