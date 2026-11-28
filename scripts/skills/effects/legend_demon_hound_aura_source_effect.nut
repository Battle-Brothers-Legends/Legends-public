this.legend_demon_hound_aura_source_effect <- this.inherit("scripts/skills/skill", {
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundAuraSource);
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}

	function refreshEffect() {
		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && ::Legends.Effects.has(_entity, ::Legends.Effect.LegendDemonHoundAura)))) {
			entity.getSkills().update();
			entity.setDirty(true);
		}
	}

	function onMovementFinished() {
		this.refreshEffect();		
	}

	function applyAura() {
		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(::MSU.isKindOf(_entity, "human")))) {
			::Legends.Effects.grant(entity, ::Legends.Effect.LegendDemonHoundAura);
		}
	}

	function onDeath() {
		this.refreshEffect();		
	}
});
