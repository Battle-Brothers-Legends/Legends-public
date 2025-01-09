this.legend_prosthetic_eye_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_prosthetic_eye";
		this.m.Type = this.Const.Items.ItemType.Usable
		this.m.PreviewCraftable = this.new("scripts/items/misc/legend_prosthetic_eye_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 1
			}
		]
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Const.Perks.PerkDefs.LegendInventorAnatomy)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/legend_prosthetic_eye_item"));
	}

});

