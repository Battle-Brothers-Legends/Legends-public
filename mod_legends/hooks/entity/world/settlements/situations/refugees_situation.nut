::mods_hookExactClass("entity/world/settlements/situations/refugees_situation", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function (_settlement) {
		_settlement.setResources(_settlement.getResources() * 0.9);
		onAdded(_settlement);
	}

	o.onUpdateDraftList = function (_draftList) {
		::Legends.S.extend(_draftList, ::Legends.Background.Refugee, 30);

		_draftList.push(::Legends.Background.Slave);
		_draftList.push(::Legends.Background.Beggar);
	}
});
