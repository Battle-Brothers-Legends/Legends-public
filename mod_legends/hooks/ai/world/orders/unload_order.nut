::mods_hookExactClass("ai/world/orders/unload_order", function(o)
{
	local onExecute = o.onExecute;
	o.onExecute = function ( _entity, _hasChanged )
	{
		if (!::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			return onExecute(_entity, _hasChanged);

		if (!_entity.getFlags().has("CaravanDestinationID"))
			return onExecute(_entity, _hasChanged);

		local settlement = ::World.getEntityByID(_entity.getFlags().get("CaravanDestinationID"));

		if (settlement == null || !settlement.isLocation() || !settlement.isLocationType(::Const.World.LocationType.Settlement)) {
			::logError("Error: Can not unloading caravan stash. Reason: Desitnation settlement is missing or not a valid settlement.");
			this.getController().popOrder();
			return true;
		}

		local inv = _entity.getStashInventory().getItems();
		local origin = _entity.getOrigin();
		local investment = _entity.getFlags().getAsInt("CaravanInvestment");
		local profit = _entity.getFlags().getAsInt("CaravanProfit");

		if (origin != null) {
			local coords = settlement.getTile().Coords;
			local caravanHistoryData = ::Const.World.Common.WorldEconomy.Trade.createCaravanHistoryData(::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Completed, origin.getID(), settlement.getID(), investment, profit, inv, [coords.X, coords.Y]);
			origin.updateCaravanSentHistory(caravanHistoryData);
			settlement.updateCaravanReceivedHistory(caravanHistoryData);
			origin.addWorldEconomyResources(_entity.getFlags().getAsInt("CaravanInvestment") + _entity.getFlags().getAsInt("CaravanProfit"));
			//this.logWarning("Unloading caravan with " + inv.len() + " items at " + settlement.getName() + ", the origin town " + origin.getName() + " receives their investment of " + investment + " resources along wiht a profit of " + profit + ", now have " + origin.getResources() + " resources in total");
		}

		// unload all items to the marketplace
		foreach( item in inv )
		{
			settlement.addImportedProduce(item);
			//this.logWarning("Moving \'" + item.getName() + "\' to " + settlement.getName() +  "\'s marketplace");
		}

		local storage = settlement.getImportedGoodsInventory().getItems();
		local marketplace = settlement.getBuilding("building.marketplace");
		// if there already too many items in storage, the excess one will be pushed to the marketplace immediately
		// in order to keep the storage at a certain size
		// this also lets the settlement to continue shipping these items to another place :)
		if (marketplace != null && storage.len() > ::Const.World.Common.WorldEconomy.Trade.ImportedGoodsInventorySizeMax) {
			local different = storage.len() - ::Const.World.Common.WorldEconomy.Trade.ImportedGoodsInventorySizeMax;
			local newStorage = [];

			foreach (i, item in storage )
			{
				if (i >= different) newStorage.push(item);
				else marketplace.getStash().add(item);
			}

			settlement.getImportedGoodsInventory().assign(newStorage);
		}

		_entity.clearInventory();
		getController().popOrder();
		return true;
	}
});
