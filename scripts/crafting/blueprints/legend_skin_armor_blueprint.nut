this.legend_skin_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_skin_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/armor/legendary/legend_skin_armor");
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_armor_skin");
		}		
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
				Num = 6
			}
		];

		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_gambeson",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/legend_armor/chain/legend_armor_hauberk",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/armor/mail_hauberk",
			Num = 1,
			LegendsArmor = false
		})

		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_blacksmith_background"]
			}
		]
		this.initSkills(skills);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local item;
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			item = this.new("scripts/items/legend_armor/legendary/legend_armor_skin");
		}
		else
		{
			item = this.new("scripts/items/armor/legendary/legend_skin_armor");
		}
		item.m.Name = "";
		_stash.add(item);
	}

});

