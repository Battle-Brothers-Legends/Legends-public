::mods_hookExactClass("entity/world/settlements/situations/greenskins_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Greenskins are terrorizing the surrounding lands, and many lives have been lost as orcs or goblins continue to raid outlying farms and raze caravans. Supplies are beginning to run low and people become desperate. Deserters fleeing the carnage are seeking refuge, while mercenaries claiming to be able to protect the locals are seeking coin.";
		this.m.Rumors.push("I just don\'t understand it. We had bunch of poor sods come by from %settlement% muttering that no noble house can promise them enough fortunes to fight a greenskin army ever again. Even so, a bunch of sheep-headed fools calling themselves sellswords said they were heading in that direction precisely for the coin.");
	}

	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);

		if (::Math.rand(1, 10) == 1) {
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1, 3));
		}

		onAdded(_settlement);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legends_necro", "scenario.legends_solo_necro")) {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendPuppet, 4);
		} else if (this.World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms, 2);
		}

		::Legends.S.extend(_draftList, ::Legends.Background.Deserter, 4);
		::Legends.S.extend(_draftList, ::Legends.Background.Sellsword, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.HedgeKnight, 2);
	}
});
