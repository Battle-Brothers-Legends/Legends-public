this.legend_stake_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_stake_blueprint";
		this.m.Type = this.Const.Items.ItemType.Weapon;
		this.m.PreviewCraftable = this.new("scripts/items/weapons/legend_wooden_stake");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_raw_wood_item", 
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/backgrounds/witchhunter_background",
					"scripts/skills/backgrounds/legend_youngblood_background"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/weapons/legend_wooden_stake");
		local item = this.new("scripts/items/weapons/legend_wooden_stake");
		item.setVariant(this.m.PreviewCraftable.m.Variant);
		_stash.add(item);
	}

});

