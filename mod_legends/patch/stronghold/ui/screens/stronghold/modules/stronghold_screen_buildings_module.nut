::mods_hookExactClass("ui/screens/stronghold/modules/stronghold_screen_buildings_module", function (o) {
	// Stronghold stocked a new building through situation.onUpdateShop(), which doesn't exist anymore
	o.addBuilding = function (_data) {
		local buildingDef = ::Stronghold.Buildings[_data];
		::Stronghold.addRoundedMoney(-buildingDef.Price * ::Stronghold.GeneralSettings.PriceMult);
		local building = ::new("scripts/entity/world/settlements/buildings/" + buildingDef.Path);
		this.getTown().addBuilding(building);

		if (building.getStash() != null) {
			local list = building.onUpdateShopList();
			this.getTown().onUpdateShopList(building.getID(), list);
			building.fillStash(list, building.getStash(), building.getPriceMult(), building.getAllowDamaged());
		}

		this.updateData(["TownAssets", "Assets", "BuildingsModule"]);
	}
});
