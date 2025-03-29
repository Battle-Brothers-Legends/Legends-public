this.legend_stollwurm_scales_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_stollwurm_scales_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_stollwurm_scales_upgrade");
		this.m.Cost = 700;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_stollwurm_scales_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
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
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_stollwurm_scales_upgrade"));
	}

	// Todo: delete this recipe. Currently it is just deactivated so that it can be tested
	function isValid()	// Deactives this recipe as it was replaced by another legends recipe.
	{
		return false;
	}

});

