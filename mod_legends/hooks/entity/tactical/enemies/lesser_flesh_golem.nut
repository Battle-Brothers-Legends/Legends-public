::mods_hookExactClass("entity/tactical/enemies/lesser_flesh_golem", function(o) {
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAnchor);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
		}
	}
});
