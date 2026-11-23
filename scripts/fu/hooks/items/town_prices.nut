// Vanilla 1.5.2.3 price implementations, with town reads routed through FU.
// Identical implementations share closures; only producer/building IDs differ.
// Keep item-specific multipliers, culture, difficulty, rounding and buyback rules.
// Legends and other mods can still wrap/override these ordinary item methods.
local function installPrices( _path, _methods )
{
	::mods_hookExactClass(_path, function(o) {
		foreach (name, method in _methods) o[name] = method;
	});
}
local function make_alp_trophy_prices( _locations = null )
{
	return {
		getSellPriceMult = function()
		{
			return ::FU.GetTown().getBeastPartsPriceMult();
		},
		getBuyPriceMult = function()
		{
			return ::FU.GetTown().getBeastPartsPriceMult();
		}
	};
}
foreach (path in [
	"items/accessory/alp_trophy_item",
	"items/accessory/ghoul_trophy_item",
	"items/accessory/hexen_trophy_item",
	"items/misc/acidic_saliva_item",
	"items/misc/adrenaline_gland_item",
	"items/misc/ancient_wood_item",
	"items/misc/frost_unhold_fur_item",
	"items/misc/ghoul_brain_item",
	"items/misc/ghoul_horn_item",
	"items/misc/ghoul_teeth_item",
	"items/misc/glistening_scales_item",
	"items/misc/glowing_resin_item",
	"items/misc/heart_of_the_forest_item",
	"items/misc/hyena_fur_item",
	"items/misc/kraken_horn_plate_item",
	"items/misc/kraken_tentacle_item",
	"items/misc/lindwurm_blood_item",
	"items/misc/lindwurm_bones_item",
	"items/misc/lindwurm_scales_item",
	"items/misc/mysterious_herbs_item",
	"items/misc/parched_skin_item",
	"items/misc/petrified_scream_item",
	"items/misc/poison_gland_item",
	"items/misc/poisoned_apple_item",
	"items/misc/serpent_skin_item",
	"items/misc/spider_silk_item",
	"items/misc/sulfurous_rocks_item",
	"items/misc/third_eye_item",
	"items/misc/unhold_bones_item",
	"items/misc/unhold_heart_item",
	"items/misc/unhold_hide_item",
	"items/misc/vampire_dust_item",
	"items/misc/werewolf_pelt_item",
	"items/misc/witch_hair_item"
]) installPrices(path, make_alp_trophy_prices());

local function make_base_item_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
			}
			else
			{
				return this.Math.ceil(this.getValue() * this.getPriceMult());
			}
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * ::FU.GetTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
			}
			else
			{
				return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
			}
		}
	};
}
foreach (path in [
	"items/item"
]) installPrices(path, make_base_item_prices());

local function make_ancient_amber_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * 1.5 * ::FU.GetTown().getBuyPriceMult() * ::FU.GetTown().getBeastPartsPriceMult()));
			}
			else
			{
				return this.Math.ceil(this.getValue());
			}
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseLootSellPrice * ::FU.GetTown().getSellPriceMult() * ::FU.GetTown().getBeastPartsPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
			}
			else
			{
				return this.Math.floor(this.getValue());
			}
		}
	};
}
foreach (path in [
	"items/loot/ancient_amber_item",
	"items/loot/deformed_valuables_item",
	"items/loot/glittering_rock_item",
	"items/loot/growth_pearls_item",
	"items/loot/jade_broche_item",
	"items/loot/lindwurm_hoard_item",
	"items/loot/rainbow_scale_item",
	"items/loot/sabertooth_item",
	"items/loot/soul_splinter_item",
	"items/loot/webbed_valuables_item"
]) installPrices(path, make_ancient_amber_prices());

local function make_ancient_gold_coins_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * 1.5 * ::FU.GetTown().getBuyPriceMult()));
			}
			else
			{
				return this.Math.ceil(this.getValue());
			}
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseLootSellPrice * ::FU.GetTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
			}
			else
			{
				return this.Math.floor(this.getValue());
			}
		}
	};
}
foreach (path in [
	"items/loot/ancient_gold_coins_item",
	"items/loot/bead_necklace_item",
	"items/loot/bone_figurines_item",
	"items/loot/gemstones_item",
	"items/loot/goblin_carved_ivory_iconographs_item",
	"items/loot/goblin_minted_coins_item",
	"items/loot/goblin_rank_insignia_item",
	"items/loot/golden_chalice_item",
	"items/loot/jeweled_crown_item",
	"items/loot/looted_valuables_item",
	"items/loot/marble_bust_item",
	"items/loot/ornate_tome_item",
	"items/loot/signet_ring_item",
	"items/loot/silver_bowl_item",
	"items/loot/silverware_item",
	"items/loot/valuable_furs_item",
	"items/loot/white_pearls_item",
	"items/special/golden_goose_item"
]) installPrices(path, make_ancient_gold_coins_prices());

local function make_snake_oil_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * ::FU.GetTown().getBeastPartsPriceMult()));
			}
			else
			{
				return this.Math.ceil(this.getValue());
			}
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * ::FU.GetTown().getBeastPartsPriceMult());
			}
			else
			{
				return this.Math.floor(this.getValue());
			}
		}
	};
}
foreach (path in [
	"items/misc/snake_oil_item"
]) installPrices(path, make_snake_oil_prices());

local function make_ammo_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]) || ::FU.GetTown().hasBuilding(_locations[1]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? 1.0 : 1.5)));
			}

			return this.item.getBuyPrice();
		}
	};
}
installPrices("items/supplies/ammo_item", make_ammo_prices(["attached_location.fletchers_hut", "building.fletcher"]));

local function make_armor_parts_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (::FU.GetTown() != null)
			{
				local t = ::FU.GetTown();
				local isBuildingPresent = t.hasAttachedLocation(_locations[0]) || t.hasAttachedLocation(_locations[1]) || t.hasBuilding(_locations[2]) || t.hasBuilding(_locations[3]) || t.hasBuilding(_locations[4]) || t.hasBuilding(_locations[5]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? 1.0 : 1.5)));
			}

			return this.item.getBuyPrice();
		}
	};
}
installPrices("items/supplies/armor_parts_item", make_armor_parts_prices(["attached_location.workshop", "attached_location.leather_tanner", "building.armorsmith", "building.armorsmith_oriental", "building.weaponsmith", "building.weaponsmith_oriental"]));

local function make_beer_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
			}

			return this.item.getSellPrice();
		}
	};
}
installPrices("items/supplies/beer_item", make_beer_prices(["attached_location.brewery"]));
installPrices("items/supplies/bread_item", make_beer_prices(["attached_location.wheat_fields"]));
installPrices("items/supplies/cured_venison_item", make_beer_prices(["attached_location.hunters_cabin"]));
installPrices("items/supplies/dates_item", make_beer_prices(["attached_location.plantation"]));
installPrices("items/supplies/dried_fruits_item", make_beer_prices(["attached_location.orchard"]));
installPrices("items/supplies/dried_lamb_item", make_beer_prices(["attached_location.goat_herd"]));
installPrices("items/supplies/mead_item", make_beer_prices(["attached_location.beekeeper"]));
installPrices("items/supplies/pickled_mushrooms_item", make_beer_prices(["attached_location.mushroom_grove"]));
installPrices("items/supplies/roots_and_berries_item", make_beer_prices(["attached_location.gatherers_hut"]));
installPrices("items/supplies/smoked_ham_item", make_beer_prices(["attached_location.pig_farm"]));

local function make_black_marsh_stew_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult() * this.Const.World.Assets.BuyPriceNotProducedHere));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult() * this.Const.World.Assets.SellPriceNotProducedHere);
			}

			return this.item.getSellPrice();
		}
	};
}
foreach (path in [
	"items/supplies/black_marsh_stew_item",
	"items/supplies/cured_rations_item",
	"items/supplies/fermented_unhold_heart_item",
	"items/supplies/preserved_mead_item"
]) installPrices(path, make_black_marsh_stew_prices());

local function make_dried_fish_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]) || ::FU.GetTown().hasAttachedLocation(_locations[1]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]) || ::FU.GetTown().hasAttachedLocation(_locations[1]);
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
			}

			return this.item.getSellPrice();
		}
	};
}
installPrices("items/supplies/dried_fish_item", make_dried_fish_prices(["attached_location.fishing_huts", "attached_location.harbor"]));

local function make_goat_cheese_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getBuyPriceMult() * ::FU.GetTown().getFoodPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
			}

			return this.item.getSellPrice();
		}
	};
}
installPrices("items/supplies/goat_cheese_item", make_goat_cheese_prices(["attached_location.goat_herd"]));

local function make_ground_grains_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult()));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult());
			}

			return this.item.getSellPrice();
		}
	};
}
foreach (path in [
	"items/supplies/ground_grains_item",
	"items/supplies/strange_meat_item"
]) installPrices(path, make_ground_grains_prices());

local function make_medicine_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]) || ::FU.GetTown().hasAttachedLocation(_locations[1]) || ::FU.GetTown().hasAttachedLocation(_locations[2]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * ::FU.GetTown().getBuyPriceMult() * ::FU.GetTown().getModifiers().MedicalPriceMult * (isBuildingPresent ? 1.0 : 1.5)));
			}

			return this.item.getBuyPrice();
		}
	};
}
installPrices("items/supplies/medicine_item", make_medicine_prices(["attached_location.herbalists_grove", "attached_location.mushroom_grove", "attached_location.gatherers_hut"]));

local function make_rice_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getBuyPriceMult() * this.Const.World.Assets.BaseBuyPrice));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult() * this.Const.World.Assets.BaseSellPrice);
			}

			return this.item.getSellPrice();
		}
	};
}
foreach (path in [
	"items/supplies/rice_item"
]) installPrices(path, make_rice_prices());

local function make_wine_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * ::FU.GetTown().getFoodPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? 1.0 : 1.5)));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isBuildingPresent = ::FU.GetTown().hasAttachedLocation(_locations[0]);
				return this.Math.floor(this.getValue() * this.getSellPriceMult() * ::FU.GetTown().getFoodPriceMult() * ::FU.GetTown().getSellPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
			}

			return this.item.getSellPrice();
		}
	};
}
installPrices("items/supplies/wine_item", make_wine_prices(["attached_location.winery"]));

local function make_copper_ingots_prices( _locations = null )
{
	return {
		getSellPriceMult = function()
		{
			return ::FU.GetTown().getModifiers().BuildingPriceMult;
		},
		getBuyPriceMult = function()
		{
			return ::FU.GetTown().getModifiers().BuildingPriceMult;
		}
	};
}
foreach (path in [
	"items/trade/copper_ingots_item",
	"items/trade/quality_wood_item"
]) installPrices(path, make_copper_ingots_prices());

local function make_incense_prices( _locations = null )
{
	return {
		getSellPriceMult = function()
		{
			return ::FU.GetTown().getModifiers().IncensePriceMult;
		},
		getBuyPriceMult = function()
		{
			return ::FU.GetTown().getModifiers().IncensePriceMult;
		}
	};
}
foreach (path in [
	"items/trade/incense_item"
]) installPrices(path, make_incense_prices());

local function make_trading_good_prices( _locations = null )
{
	return {
		getBuyPrice = function()
		{
			if (this.m.IsSold)
			{
				return this.getSellPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isLocalCulture = this.m.Culture == this.Const.World.Culture.Neutral || ::FU.GetTown().getCulture() == this.m.Culture || ::FU.GetTown().hasBuilding(_locations[0]);
				local isBuildingPresent = false;

				foreach( b in this.m.ProducingBuildings )
				{
					if (::FU.GetTown().hasAttachedLocation(b))
					{
						isBuildingPresent = true;
						break;
					}
				}

				return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.World.Assets.m.BuyPriceTradeMult * this.getPriceMult() * ::FU.GetTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere) * (isLocalCulture ? 1.0 : this.Const.World.Assets.BuyPriceNotLocalCulture)));
			}

			return this.item.getBuyPrice();
		},
		getSellPrice = function()
		{
			if (this.m.IsBought)
			{
				return this.getBuyPrice();
			}

			if (::FU.GetTown() != null)
			{
				local isLocalCulture = this.m.Culture == this.Const.World.Culture.Neutral || ::FU.GetTown().getCulture() == this.m.Culture || ::FU.GetTown().hasBuilding(_locations[0]);
				local isBuildingPresent = false;

				foreach( b in this.m.ProducingBuildings )
				{
					if (::FU.GetTown().hasAttachedLocation(b))
					{
						isBuildingPresent = true;
						break;
					}
				}

				return this.Math.floor(this.getValue() * this.getSellPriceMult() * this.World.Assets.m.SellPriceTradeMult * ::FU.GetTown().getSellPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere) * (isLocalCulture ? 1.0 : this.Const.World.Assets.SellPriceNotLocalCulture));
			}

			return this.item.getSellPrice();
		}
	};
}
installPrices("items/trade/trading_good_item", make_trading_good_prices(["building.port"]));

