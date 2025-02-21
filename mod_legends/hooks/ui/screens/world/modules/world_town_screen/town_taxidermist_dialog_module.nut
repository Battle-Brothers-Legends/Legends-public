::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_taxidermist_dialog_module", function(o) {

	o.m.InventoryFilter <- this.Const.Items.ItemFilter.All;
	o.m.CurrentPage <- 0;

	o.onModuleShown <- function ()
	{
		this.m.CurrentPage = 0;
		this.ui_module.onModuleShown();
	}

	local queryBlueprints = o.queryBlueprints;
	o.queryBlueprints = function()
	{
		local result = queryBlueprints();
		result.SubTitle = "A taxidermist can create useful items from all kinds of beast trophies that you bring";
		local bps = ::World.Crafting.getQualifiedBlueprintsForUI(this.m.InventoryFilter);
		local indexStart = this.m.CurrentPage * 4;
		result.Blueprints = bps.slice(indexStart, ::Math.min(indexStart + 4, bps.len()));
		result.CurrentPage <- this.m.CurrentPage;
		result.Pages <- ::Math.floor((bps.len() + 3) / 4);
		return result;
	}

	o.loadBlueprints <- function ()
	{
		local result = this.queryBlueprints();
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	o.onFilterAll <- function ()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.All)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.All;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	o.onFilterWeapons <- function ()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Weapons)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Weapons;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	o.onFilterArmor <- function ()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Armor)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Armor;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	o.onFilterMisc <- function ()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Misc)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Misc;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	o.onFilterUsable <- function ()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Usable)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Usable;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	o.onPageChange <- function (_result) {
		this.m.CurrentPage = _result.ID;
		this.loadBlueprints();
	}

	o.FixVariantImage <- function ( _result )
	{
		local result = null;
		if (_result.ItemPath != 0)
		{
			local item = this.new(_result.ItemPath);
			if ("m" in item && "Faction" in item.m)
			{
				item.setFaction(_result.Variant);
			}
			else
			{
				item.setVariant(item.m.Variants[_result.Variant-1]);
			}
			if (item.m.ID == "shield.faction_kite_shield" || item.m.ID == "shield.heater_kite_shield")
			{
				local blueprint = this.World.Crafting.getBlueprint(_result.ID);
				blueprint.m.PreviewCraftable = item;
			}
			result = item.m.IconLarge != null ? item.m.IconLarge : item.m.Icon;
		}

		return result;
	}

	o.onCraft = function ( _result )
	{
		local blueprint = this.World.Crafting.getBlueprint(_result.ID);
		if (_result.Variant != 0)
		{
			blueprint.setVariant(_result.Variant);
		}
		blueprint.craft();
		this.World.Assets.addMoney(-blueprint.getCost());

		if (blueprint.getSounds().len() != 0)
		{
			this.Sound.play(blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}

		this.World.Statistics.getFlags().increment("ItemsCrafted");
		this.World.Ambitions.updateUI();

		if (blueprint.isCraftable())
		{
			return {
				Blueprints = null,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}
		else
		{
			return this.queryBlueprints();
		}
	}
});
