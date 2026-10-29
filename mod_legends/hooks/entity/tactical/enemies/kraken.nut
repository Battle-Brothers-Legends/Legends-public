::mods_hookExactClass("entity/tactical/enemies/kraken", function (o) {
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		this.m.BaseProperties.IsAffectedByRain = false;
	}
});
