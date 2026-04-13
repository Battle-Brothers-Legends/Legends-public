this.legend_drums_of_life_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Effect = 0,
		AffectedActors = [],
		Caster = null
	},

	function setEffect( _e )
	{
		this.m.Effect = _e;
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDrumsOfLife);
		this.m.Description = "";
		this.m.Icon = "ui/perks/drums_of_life.png";
		this.m.Overlay = "drums_of_life_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getHitpoints() < actor.getHitpointsMax()) {
			actor.setHitpoints(this.Math.max(0, this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.m.Effect)));
			if (actor.isPlacedOnMap())
				this.spawnIcon(this.m.Overlay, actor.getTile());
		}
	}

	function onTurnStart() {
		if (::Legends.S.isNull(this.m.Caster))
			return;
		this.removeEffectFromAffected();
	}

	function onDeath(_fatalityType) {
		if (::Legends.S.isNull(this.m.Caster))
			return;
		this.removeEffectFromAffected();
	}

	function onCombatFinished() {
		this.m.Caster = null;
		this.m.AffectedActors = [];
		this.removeSelf();
	}

	function removeEffectFromAffected() {
		foreach(actor in this.m.AffectedActors) {
			if (::Legends.S.skillEntityAliveCheck(actor))
				continue;
			::Legends.Effects.remove(actor.getSkills(), ::Legends.Effect.LegendDrumsOfLife);
		}
		this.m.AffectedActors = [];
		this.m.Caster = null;
		this.removeSelf();
	}
});

