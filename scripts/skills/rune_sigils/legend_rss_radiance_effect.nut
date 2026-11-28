this.legend_rss_radiance_effect <- this.inherit("scripts/skills/skill", {
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssRadiance);
		this.m.Description = "Rune Sigil: Radiance";
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}

	function refreshEffect() {
		local actor = this.getContainer().getActor();
		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && !_entity.isAlliedWith(actor) && ::Legends.Effects.has(_entity, ::Legends.Effect.LegendRssRadianceBlind)))) {
			entity.getSkills().update();
			entity.setDirty(true);
		}
	}

	function onMovementFinished() {
		this.refreshEffect();
	}

	function applyRadianceFoundation() {
		if (this.getItem() == null) {
			return;
		}
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		foreach (entity in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && !_entity.isAlliedWith(actor) && !::Legends.Effects.has(_entity, ::Legends.Effect.LegendRssRadianceBlind)))) {
			::Legends.Effects.grant(entity, ::Legends.Effect.LegendRssRadianceBlind);
		}
	}

	function onTurnStart() {
		this.applyRadianceFoundation();
	}

	function applyAura() {
		this.applyRadianceFoundation();
	}

	function onDeath(_fatalityType) {
		this.refreshEffect();
	}
});
