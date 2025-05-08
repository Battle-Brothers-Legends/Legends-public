this.legend_warlock_hood_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_warlock_hood";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = this.new("scripts/items/legend_helmets/named/legend_named_warlock_hood");
		preview.resetStats();
		this.m.PreviewCraftable = preview;
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/misc/witch_hair_item",
				Num = 2
			},
			{
				Script = "scripts/items/spawns/legend_zombie_item",
				Num = 1
			}
		];
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
		local item = this.new("scripts/items/legend_helmets/named/legend_named_warlock_hood");
		item.setVariant(this.m.PreviewCraftable.m.Variant);
		_stash.add(item);
	}

});

