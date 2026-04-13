this.legend_enraged_hyena_bite_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Hyena = null,
		Token = null,
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendEnragedHyenaBite);
		this.m.Description = "This character is held immobilized in the jaws of an enraged hyena. Their defenses are severely compromised and they cannot move until freed by attacking the hyena or by disengaging.";
		this.m.Icon = "skills/legend_enraged_hyena_bite_effect.png";
		this.m.IconMini = "legend_enraged_hyena_bite_effect_mini";
		this.m.Overlay = "legend_enraged_hyena_bite_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-45%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-45%[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-45%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be removed by attacking the hyena or by disengaging"
			}
		];
	}

	function onUpdate(_properties) {
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.55;
		_properties.RangedDefenseMult *= 0.55;
		_properties.InitiativeMult *= 0.55;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		if (!actor.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is locked in the hyena's jaws!");
		}

		if (!actor.hasSprite("status_bite")) {
			actor.addSprite("status_bite").setBrush("legend_enraged_hyena_bite_effect");
		}
		actor.getSprite("status_bite").Visible = true;
		actor.setDirty(true);

		// Generate a unique token for this instance (idk how to make refs work properly)
		this.m.Token = this.Math.rand(1, 2147483647);

		// Tag victim with attacker
		actor.getFlags().set("LegendEnragedHyenaAttacker", this.m.Token);

		// Tag attacker with victim
		if (this.m.Hyena == null) {
			::logError("legend_enraged_hyena_bite_effect: onAdded called but Hyena is null");
		} else {
			this.m.Hyena.getFlags().set("LegendEnragedHyenaBiteVictim", this.m.Token);
		}
	}

	function onRemoved() {
		local actor = this.getContainer().getActor();
		if (!actor.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " breaks free from the hyena's bite!");
		}

		// Clear attacker from victim
		actor.getFlags().remove("LegendEnragedHyenaAttacker");

		if (actor.hasSprite("status_bite")) {
			actor.getSprite("status_bite").Visible = false;
			actor.setDirty(true);
		}

		// Clear victim from attacker
		if (this.m.Hyena == null) {
			::logError("legend_enraged_hyena_bite_effect: onRemoved called but Hyena is null");
		} else {
			this.m.Hyena.getFlags().remove("LegendEnragedHyenaBiteVictim");
			::Legends.Effects.remove(this.m.Hyena, ::Legends.Effect.LegendEnragedHyenaGrip);
		}
	}

	function onTurnStart() {
		// Check if the hyena is still alive and adjacent
		if (::Legends.S.skillEntityAliveCheck(this.m.Hyena)) {
			// Hyena is dead or invalid, free the victim
			this.removeSelf();
			return;
		}

		local victimTile = this.getContainer().getActor().getTile();
		local hyenaTile = this.m.Hyena.getTile();

		// Check if hyena is still adjacent (within 1 tile)
		if (victimTile.getDistanceTo(hyenaTile) > 1) {
			// Hyena moved away, free the victim
			this.removeSelf();
			return;
		}
	}

	function onMovementFinished() {
		if (this.m.Hyena == null || ::Legends.S.skillEntityAliveCheck(this.m.Hyena)) {
			this.removeSelf();
			return;
		}

		local victimTile = this.getContainer().getActor().getTile();
		local hyenaTile = this.m.Hyena.getTile();
		if (victimTile == null || hyenaTile == null) {
			this.removeSelf();
			return;
		}

		if (victimTile.getDistanceTo(hyenaTile) > 1) {
			this.removeSelf();
		}
	}

	function setHyena(_hyena) {
		this.m.Hyena = _hyena;
	}

});
