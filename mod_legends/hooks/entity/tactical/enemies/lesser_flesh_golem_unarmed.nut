::mods_hookExactClass("entity/tactical/enemies/lesser_flesh_golem_unarmed", function(o) {
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAmbidextrous);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPugilist);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPummelIntoSubmission);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendGrappler);
			b.Hitpoints *= 1.5;
		}

		::Legends.S.scaleBaseProperties(b);
	}
});
