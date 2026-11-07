this.perk_legend_escape_artist <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendEscapeArtist);
	}

	// Note: As of Legends 18.2.0, this perk is no longer purchaseable by players (its effects have been merged into by Net Mastery)
	// The perk will continue to exist so that it can be used by non-player actors

	function onAfterUpdate(_properties) {
		local actor = this.getContainer().getActor();
		foreach (skillDef in this.m.AffectedSkills.filter(@(_, _skillDef)(::Legends.Actives.has(actor, _skillDef)))) {
			local skill = ::Legends.Actives.get(actor, skillDef);
			skill.m.ActionPointCost -= 1;
			skill.m.FatigueCostMult *= 0.33;
		}
	}
});
