this.perk_legend_mastery_nets <- this.inherit("scripts/skills/skill", {
	m = {
		AffectedSkills = [
			::Legends.Active.BreakAllyFree,
			::Legends.Active.BreakFree
		]
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryNets);
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInNets = true;
	}

	function onAfterUpdate(_properties) {
		local actor = this.getContainer().getActor();
		foreach (skillDef in this.m.AffectedSkills.filter(@(_, _skillDef)(::Legends.Actives.has(actor, _skillDef)))) {
			local skill = ::Legends.Actives.get(actor, skillDef);
			skill.m.ActionPointCost -= 1;
			skill.m.FatigueCostMult *= 0.33;
		}
	}
});
