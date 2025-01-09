this.legend_net_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_net_blueprint";
		this.m.Type = this.Const.Items.ItemType.Weapon;
		this.m.PreviewCraftable = this.new("scripts/items/tools/throwing_net");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendNetRepair)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/throwing_net"));
		_stash.add(this.new("scripts/items/tools/throwing_net"));
	}

});

