::mods_hookExactClass("skills/actives/footwork", function(o) {
	o.onAfterUpdate = function(_properties) {
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip)) {
			this.m.MaxRange = 2;
		}
		_properties.SkillCostAdjustments.push({
			// fix vanilla bullshit with hard setting fat cost in onAfterUpdate
			ID = this.m.ID,
			APAdjust = ::Legends.Effects.has(this.getContainer(), ::Legends.Effect.GoblinGruntPotion) ? -1 : 0,
			FatigueMultAdjust = _properties.IsFleetfooted ? 0.5 : 1.0
		});
	}
});
