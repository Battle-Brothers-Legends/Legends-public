this.legend_bandage_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_bandage_blueprint";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/medicine_small_item");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/accessory/bandage",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isCraftable()
	{
		local roster = this.World.getPlayerRoster().getAll();
        foreach( bro in roster )
        {
            if (bro.getSkills().hasSkill("perk.legend_med_ingredients") )
            {
                return true
            }
		}
		return false;
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/medicine_small_item"));

	}

});

