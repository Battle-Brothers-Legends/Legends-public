this.legend_demon_hound_aura_source_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundAuraSource);
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}

	function onMovementFinished() {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && ::Legends.Effects.has(_entity, ::Legends.Effect.LegendDemonHoundAura)))) {
			entity.getSkills().update();
			entity.setDirty(true);
		}
	}

	function onAdded() {
		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(::MSU.isKindOf(_entity, "human")))) {
			::Legends.Effects.grant(entity, ::Legends.Effect.LegendDemonHoundAura);
		}
	}
});
