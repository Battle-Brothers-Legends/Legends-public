::mods_hookExactClass("entity/world/settlements/situations/terrified_villagers_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "The villagers here are terrified of unknown horrors. Fewer potential recruits are to be found on the streets, and people deal less favourably with strangers. Those formerly in the business of graves are rightfully seeking new employment. Upon resolution this will refresh the hiring roster in town.";
		this.m.Rumors.push("Aye, it\'s a bad time to be in the gravedigging or graverobbing business, I tell ye. Especially if you are in %settlement%!");
	}

	o.onAdded <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.975);

		_settlement.resetRoster(true);		
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);

		_settlement.resetRoster(true);

		if (::Math.rand(1, 10) == 1) {
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1, 3));
		}
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Gravedigger, 6);
	}
});
