this.herbal_recovery_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.herbal_recovery_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/recovery_potion_item");
		this.m.Cost = 30;
		local ingredients = [
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 2
			},
			{
				Script = "scripts/items/accessory/legend_apothecary_mushrooms_item",
				Num = 1
			},
			{
				Script = "scripts/items/accessory/berserker_mushrooms_item",
				Num = 1
			},
			{
				Script = "scripts/items/accessory/antidote_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendPotionBrewer)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/recovery_potion_item"));
	}

});

