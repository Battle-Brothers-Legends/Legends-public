this.legend_restored_ancient_helm_02 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_restored_ancient_helm_02";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/helm/legend_helmet_legend_ancient_legionaire_restored");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_dome",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_tailed_conic_helm",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_side_hawk",
				Num = 1,
				LegendsArmor = true
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_helmets/helm/legend_helmet_legend_ancient_legionaire_restored"));
	}

});

