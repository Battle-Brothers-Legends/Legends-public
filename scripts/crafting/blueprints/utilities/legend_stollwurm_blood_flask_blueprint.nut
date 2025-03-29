this.legend_stollwurm_blood_flask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_stollwurm_blood_flask";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_stollwurm_blood_flask_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/lindwurm_blood_item",
				Num = 2
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
		_stash.add(this.new("scripts/items/accessory/legend_stollwurm_blood_flask_item"));
	}

});

