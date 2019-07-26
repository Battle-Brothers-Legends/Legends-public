this.legend_skin_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_skin_helmet";
		this.m.PreviewCraftable = this.new("scripts/items/helmets/legendary/legend_skin_helmet");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
				Num = 3
			},
			{
				Script = "scripts/items/helmets/bascinet_with_mail",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return true;
	}
	
	function onCraft( _stash )
	{
		local item = this.new("scripts/items/helmets/legendary/legend_skin_helmet");
		item.m.Name = "";
		_stash.add(item);
	}

});

