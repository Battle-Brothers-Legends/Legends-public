this.legend_lindwurm_scale_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_lindwurm_scale_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = this.new("scripts/items/legend_armor/named/legend_lindwurm_scale_armor");
		preview.resetStats();
		preview.m.Name = "Lindwurm Scales";
		this.m.PreviewCraftable = preview;
		this.m.Cost = 1500;
		local ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/legend_masterwork_metal",
				Num = 1
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
		_stash.add(this.new("scripts/items/legend_armor/named/legend_lindwurm_scale_armor"));
	}

});

