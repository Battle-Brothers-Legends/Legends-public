this.legend_enraged_hyena_bite_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Hyena = null,
	},

	function create() {
		this.m.ID = "effects.legend_enraged_hyena_bite";
		this.m.Name = "Locked in Jaws";
		this.m.Description = "This character is held immobilized in the jaws of an enraged hyena. Their defenses are severely compromised and they cannot move until freed by a melee attack on the hyena.";
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be freed by attacking the hyena"
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
		// TODO: Add visual effect showing the character is held
		if (!this.getContainer().getActor().isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is locked in the hyena's jaws!");
		}

		// Tag hyena as holding a victim
		if (this.m.Hyena == null) {
			::logError("legend_enraged_hyena_bite_effect: onAdded called but Hyena is null");
		} else {
			local flags = this.m.Hyena.getFlags();
			if (flags != null) {
				flags.set("LegendEnragedHyenaHoldingVictim", true);
			}
		}
	}

	function onRemoved() {
		if (!this.getContainer().getActor().isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " breaks free from the hyena's bite!");
		}

		// Clear hyena as holding a victim
		if (this.m.Hyena == null) {
			::logError("legend_enraged_hyena_bite_effect: onRemoved called but Hyena is null");
		} else {
			local flags = this.m.Hyena.getFlags();
			if (flags != null) {
				flags.remove("LegendEnragedHyenaHoldingVictim");
			}
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

	function setHyena(_hyena) {
		this.m.Hyena = _hyena;
	}

	function getHyena() {
		return this.m.Hyena;
	}

	// This function will be called by the hyena when it takes damage
	function checkHyenaHit() {
		this.removeSelf();
	}
});
