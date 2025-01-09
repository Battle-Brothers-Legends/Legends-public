this.legend_kite_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_kite_shield_blueprint";
		this.m.Type = this.Const.Items.ItemType.Shield;
		this.m.PreviewCraftable = this.new("scripts/items/shields/kite_shield");
		this.m.PreviewCraftable.m.Name = "Company Kite Shield";
		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendWoodworking)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/shields/kite_shield");
		item.onPaintInCompanyColors();
		_stash.add(item);
	}

});

