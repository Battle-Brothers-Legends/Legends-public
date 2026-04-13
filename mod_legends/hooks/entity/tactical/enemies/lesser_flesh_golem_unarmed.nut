::mods_hookExactClass("entity/tactical/enemies/lesser_flesh_golem_unarmed", function(o) {
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAnchor);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAmbidextrous);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPugilist);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendGrappler);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPummelIntoSubmission);
		}
	}
});
