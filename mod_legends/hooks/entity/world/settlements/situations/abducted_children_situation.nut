::mods_hookExactClass("entity/world/settlements/situations/abducted_children_situation", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Children have been disappearing from this settlement. Distrust and fear rule the streets and are slowly poisoning the community. The Witch Hunters have come to investigate.";
		this.m.Rumors.push("You didn\'t hear this from me, but a bunch of pompous-looking Witch Hunters stopped by on their way to %settlement% a few days ago. One of them was yammering on about the punishment due for those who consort with witches!");
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
		local before = _modifiers.RecruitsMult;
		onUpdate(_modifiers);
		_modifiers.RecruitsMult = before;
	}

	o.onResolved <- function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.125);
	}

	o.onUpdateDraftList <- function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Witchhunter, 6);
	}
});
