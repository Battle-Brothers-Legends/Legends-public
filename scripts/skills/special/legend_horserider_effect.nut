this.legend_horserider_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHorserider);
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = ::Const.SkillOrder.First;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
	}

	function isHidden() {
		local actor = this.getContainer().getActor();
		if (actor.getRider() == null) {
			return true;
		}
		return false;
	}

	function onCombatStarted() {
		local actor = this.getContainer().getActor();
		if (actor.getRider() == null) {
			return;
		}
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (actor.getRider() == null) {
			return;
		}
	}
});
