this.legend_RSS_radiance <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssRadiance);
		this.m.Description = "Rune Sigil: Radiance";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onMovementFinished() {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		foreach (tar in ::Tactical.Entities.getAllInstances()) {
			foreach (t in tar) {
				if (!::Legends.S.isEntityNullOrDead(t) && !t.isAlliedWith(actor) && t.getSkills().hasEffect(::Legends.Effect.LegendRssRadianceEffect)) {
					t.getSkills().update();
					t.setDirty(true);
				}
			}
		}
	}

	function applyRadianceFoundation() {
		if (this.getItem() == null) {
			return;
		}
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		foreach (tar in ::Tactical.Entities.getAllInstances()) {
			foreach (t in tar) {
				if (!::Legends.S.isEntityNullOrDead(actor) && !t.isAlliedWith(actor) && !t.getSkills().hasEffect(::Legends.Effect.LegendRssRadianceEffect))	{
					::Legends.Effects.grant(t, ::Legends.Effect.LegendRssRadianceEffect);
				}
			}
		}
	}

	function onTurnStart() {
		this.applyRadianceFoundation();
	}

	function onCombatStarted() {
		this.applyRadianceFoundation();
	}
});
