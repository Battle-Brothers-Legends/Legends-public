this.bone_platings_upgrade2_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.bone_platings_upgrade2";
		this.m.Type = this.Const.Items.ItemType.Armor;
		if (!::Legends.Mod.ModSettings.getSetting("unlayeredArmor").getValue())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade");
		}
		else
		{
			this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/bone_platings_upgrade");
		}
		this.m.Cost = 450;
		local ingredients = [
			{
				Script = "scripts/items/misc/unhold_bones_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		if (!::Legends.Mod.ModSettings.getSetting("unlayeredArmor").getValue())
		{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade"));
		}
		else
		{
		_stash.add(this.new("scripts/items/armor_upgrades/bone_platings_upgrade"));
		}
	}

});

