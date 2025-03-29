this.herbal_miracle_drug_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.herbal_miracle_drug_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/miracle_drug_item");
		this.m.Cost = 30;
		local ingredients = [
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/legend_mistletoe_item",
				Num = 1
			},
			{
				Script = "scripts/items/accessory/antidote_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendHerbcraft)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/miracle_drug_item"));
	}

});

