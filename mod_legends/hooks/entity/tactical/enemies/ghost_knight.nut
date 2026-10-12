::mods_hookExactClass("entity/tactical/enemies/ghost_knight", function (o) {
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		this.m.BaseProperties.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.remove(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendWindReader);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
			::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
			::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		}
	}
});
