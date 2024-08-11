this.legend_lindwurm_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_lindwurm_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor");
		this.m.Cost = 3500;
		local ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/legend_masterwork_fabric",
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
		_stash.add(this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor"));
	}

});

