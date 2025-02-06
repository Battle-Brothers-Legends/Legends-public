// todo delete it - chopeks
this.therianthropic_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.therianthropic_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_therianthropy_potion_item");
		this.m.Cost = 30;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_wolfsbane_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_werehand_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_white_wolf_pelt_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_ancient_scroll_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/snake_oil_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendPotionBrewer)
		];
		this.initSkills(skills);
	}

	function isQualified()
	{
		// todo delete it - chopeks
//		if (!this.LegendsMod.Configs().LegendTherianthropyEnabled())
//		{
			return false;
//		}
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_therianthropy_potion_item"));
	}

});

