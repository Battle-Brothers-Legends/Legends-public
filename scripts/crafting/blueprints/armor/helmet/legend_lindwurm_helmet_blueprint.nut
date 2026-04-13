this.legend_lindwurm_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_lindwurm_helmet";
		this.m.Type = this.Const.Items.ItemType.Armor;
		local preview = this.new("scripts/items/legend_helmets/named/legend_named_lindwurm_helmet");
		preview.resetStats();
		preview.m.Name = "Lindwurm\'s Helmet";
		this.m.PreviewCraftable = preview;
		this.m.Cost = 1500;
		local ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/legend_masterwork_fabric",
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
		_stash.add(this.new("scripts/items/legend_helmets/named/legend_named_lindwurm_helmet"));
	}

});
