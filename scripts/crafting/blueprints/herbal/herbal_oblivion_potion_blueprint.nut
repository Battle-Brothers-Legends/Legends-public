this.herbal_oblivion_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.herbal_oblivion_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/potion_of_oblivion_item");
		this.m.Cost = 30;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_demon_third_eye_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_redback_poison_gland_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_witch_leader_hair_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/snake_oil_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendPotionBrewer)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/potion_of_oblivion_item"));
	}

});

