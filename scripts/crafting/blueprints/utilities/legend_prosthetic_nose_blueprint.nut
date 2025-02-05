this.legend_prosthetic_nose_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_prosthetic_nose";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/legend_prosthetic_nose_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_wax_item",
				Num = 3
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_inventor_anatomy"]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/legend_prosthetic_nose_item"));
	}

});

