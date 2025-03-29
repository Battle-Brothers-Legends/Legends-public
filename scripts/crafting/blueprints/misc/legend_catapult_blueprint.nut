this.legend_catapult_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_catapult_blueprint";
		this.m.Type = this.Const.Items.ItemType.Weapon;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_catapult_item");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 10
			},
			{
				Script = "scripts/items/trade/copper_ingots_item",
				Num = 5
			},
			{
				Script = "scripts/items/misc/ancient_wood_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendSummonCatapult)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_catapult_item"));
	}

	function isValid()
	{
		return false;
	}

});

