::mods_hookExactClass("entity/tactical/enemies/kraken_tentacle", function (o) {
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		this.m.BaseProperties.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
	}
});
