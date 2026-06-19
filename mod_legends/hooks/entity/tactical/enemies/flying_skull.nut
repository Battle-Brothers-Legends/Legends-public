::mods_hookExactClass("entity/tactical/enemies/flying_skull", function(o) {
	o.m.IsExploded <- false;
	o.m.HasKilledPlayer <- false;

	local onInit = o.onInit;
	o.onInit = function() {
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
	}
});
