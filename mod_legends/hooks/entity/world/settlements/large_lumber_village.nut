::mods_hookExactClass("entity/world/settlements/large_lumber_village", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DraftList.extend([
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendShieldmaiden,
			::Legends.Background.LegendInventor,
			::Legends.Background.LegendDisownedLady,
		]);
	}
});
