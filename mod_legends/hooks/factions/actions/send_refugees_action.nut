::mods_hookExactClass("factions/actions/send_refugees_action", function(o)
{
	local onExecute = o.onExecute;
	o.onExecute = function (_faction) {
		local party = null;
		_faction.setSpawnListener(function(entity) {
			party = entity;
		});
		onExecute(_faction);
		party.setOrigin(this.World.State.getCurrentTown());
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue()) {
			local resources = this.Math.max(1, this.Math.round(0.01 * this.m.Start.getResources()));
			this.m.Start.setResources(this.m.Start.getResources() - resources);
			party.setResources(resources);
			local items = [
				[1, "supplies/bread_item"],
				[1, "supplies/roots_and_berries_item"],
				[1, "supplies/dried_fruits_item"],
				[1, "supplies/ground_grains_item"],
				[1, "supplies/dried_fish_item"],
				[1, "supplies/beer_item"],
				[1, "supplies/goat_cheese_item"],
				[1, "supplies/legend_fresh_fruit_item"],
				[1, "supplies/legend_fresh_meat_item"],
				[1, "supplies/legend_pie_item"],
				[1, "supplies/legend_porridge_item"],
				[1, "supplies/legend_pudding_item"],
				[1, "supplies/mead_item"],
				[0, "supplies/medicine_item"],
				[1, "supplies/pickled_mushrooms_item"],
				[1, "supplies/preserved_mead_item"],
				[1, "supplies/smoked_ham_item"],
				[1, "supplies/wine_item"]
			];
			for (local j = this.Math.rand(1,2); j != 0; j--)
				party.addToInventory(this.Const.World.Common.pickItem(items));
		}
		// add unload before despawn
		foreach (i, order in party.getController().getOrders()) {
			if (::mods_isClass(order, "despawn_order") != null) {
				local unload = this.new("scripts/ai/world/orders/unload_order");
				unload.setController(party.getController());
				party.getController().m.Orders.insert(i, unload);
				break;
			}
		}
	}
});
