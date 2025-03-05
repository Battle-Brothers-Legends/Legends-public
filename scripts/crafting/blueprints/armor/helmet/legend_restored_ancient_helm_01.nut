this.legend_restored_ancient_helm_01 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_restored_ancient_helm_01";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/helm/legend_helmet_legend_ancient_legionaire_restored");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_dome_tailed",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_face_plate",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_legionaire",
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

