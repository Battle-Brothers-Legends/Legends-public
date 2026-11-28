::mods_hookExactClass("skills/effects/withered_effect", function (o) {
	o.m.TurnsLeft = 3;
	o.m.Stacks <- 3;

	o.getDescription = function () {
		return "By means of rotten magic, this character has withered to have the physique of an old man.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		local param = [
			["_smallMalus", this.m.TurnsLeft * 5],
			["_bigMalus", this.m.TurnsLeft * 10]
		];
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-%_bigMalus%%[/color] Damage",
				param = param
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-%_bigMalus%%[/color] Initiative",
				param = param
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-%_bigMalus%%[/color] Max Fatigue",
				param = param
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/fatigue_recovery_down.png",
				text = "[color=%negative%]-%_smallMalus%[/color] Fatigue Recovery per turn",
				param = param
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%negative%]-%_bigMalus%[/color] Block",
				param = param
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The effect lessens every turn"
			}
		]);
		return tooltip;
	}

	o.onAdded = function () {
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		local statusResisted = properties.IsResistantToAnyStatuses ? ::Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || properties.IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 33 : false;

		if (statusResisted) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " quickly recovered from withering thanks to unnatural physiology");
			}
			this.removeSelf();
		} else {
			this.m.TurnsLeft = ::Math.max(1, 2 + properties.NegativeStatusEffectDuration);
			this.m.Stacks = this.m.TurnsLeft;
		}
	}

	o.onRefresh = function () {
		local actor = this.getContainer().getActor();
		this.m.TurnsLeft = ::Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		this.m.Stacks = this.m.TurnsLeft;
		this.spawnIcon("status_effect_123", actor.getTile());
	}

	o.onUpdate = function (_properties) {
		local actor = this.getContainer().getActor();
		_properties.DamageTotalMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.StaminaMult *= 1.0 - this.m.TurnsLeft * 0.10;
		_properties.FatigueRecoveryRate -= this.m.TurnsLeft * 5;
		_properties.BlockMult *= 1.0 - this.m.TurnsLeft * 0.10;

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
			actor.getSprite("status_stunned").setBrush("bust_withered");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	o.onTurnEnd = function () {
		this.m.Stacks = --this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (10 * this.m.Stacks) + "%[/color] " + ::Legends.Text.inlineIcons(["damage_dealt", "fatigue", "initiative", "block"]) + ", [color=%negative%]-" + (5 + this.m.Stacks) + "[/color] " + ::Legends.Text.inlineIcons("fatigue_recovery_down");
	}
});
