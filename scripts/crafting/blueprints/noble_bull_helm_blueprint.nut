this.noble_bull_helm_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.noble_bull_helm_blueprint";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/helmets/noble_bull_helm");
		this.m.Cost = 5000;
		local ingredients = [
			{
				Script = "scripts/items/helmets/full_helm",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return (::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue()) && this.blueprint.isQualified();
	}


	function onCraft( _stash )
	{
		local item = this.new("scripts/items/helmets/noble_bull_helm");
		item.m.Name = "Bull Full Helm";
		_stash.add(item);
	}

});

