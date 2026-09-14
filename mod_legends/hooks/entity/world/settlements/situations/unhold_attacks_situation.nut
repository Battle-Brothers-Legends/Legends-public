::mods_hookExactClass("entity/world/settlements/situations/unhold_attacks_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Large Unholds have been seen and heard in the area. The townsfolk are scared of leaving the vicinity of the settlement. Beast Slayers and Sellswords have shown up offering to slay these giants in exchange for coin.";
		this.m.Rumors.push("Only a fool would go seeking after the unholds that attacked %settlement% recently. You couldn\'t pay me enough to do it, that\'s for sure!");
	}

	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);
		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);

		_settlement.resetRoster(true);

		if (::Math.rand(1, 10) == 1) {
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1, 3));
		}
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro"))	{
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 5);
		} else if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms, 4);
		}

		::Legends.S.extend(_draftList, ::Legends.Background.BeastSlayer, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.Sellsword, 2);
	}
});
