::mods_hookExactClass("entity/world/settlements/situations/ambushed_trade_routes_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "The roads leading here are unsafe of late, and many a caravan has been ambushed and plundered. With little successful trade, the selection of goods is lower and the prices higher. Former traders and caravan hands may be looking for new jobs. Upon resolution this will refresh the hiring roster in town.";
	}

	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		onAdded(_settlement);
		_settlement.setResources(_settlement.getResources() * 0.975);

		if (::Math.rand(1, 10) == 1) {
			_settlement.addSituation(::new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1, 3));
		}
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_modifiers) {
		onUpdate(_modifiers);
		_modifiers.SellPriceMult *= 1.2 / 1.1;
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);

	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 2);
		}

		::Legends.S.extend(_draftList, ::Legends.Background.CaravanHand, 5);
		::Legends.S.extend(_draftList, ::Legends.Background.Peddler, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.Thief, 2);
	}
});
