::mods_hookExactClass("entity/world/settlements/situations/terrifying_nightmares_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "The people of this settlement are terrorized by nightmares. Many prefer to stay awake all night just to be safe. The local townsfolk have called in Witch Hunters and Beast Slayers alike, desperately hoping for either group to put an end to their terrors. Upon resolution this will refresh the hiring roster in town.";
		this.m.Rumors.push("A Witch Hunter and a Beast Hunter walked in yesterday - No! This isn\'t a joke! Anyway the two were arguing over how best to kill a monster that haunts your dreams. I would avoid %settlement% if I were you.");
	}

	o.onAdded <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);

		_settlement.resetRoster(true);
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);

		_settlement.resetRoster(true);

		if (::Math.rand(1, 10) == 1) {
			_settlement.addSituation(::new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1, 3));
		}
	}

	o.onUpdateDraftList <- function (_draftList) {
		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.S.extend(_draftList, ::Legends.Background.LegendNightwatch, 3);
			::Legends.S.extend(_draftList, ::Legends.Background.LegendManAtArms);
		}

		::Legends.S.extend(_draftList, ::Legends.Background.Witchhunter, 3);
		::Legends.S.extend(_draftList, ::Legends.Background.BeastSlayer, 2);
	}
});
