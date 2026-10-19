::mods_hookExactClass("skills/effects/orc_berserker_potion_effect", function (o) {
	o.m.Stacks <- 0;

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn."
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);

		if (this.m.Stacks > 0) {
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=%positive%]+" + this.m.Stacks + "[/color] Damage"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=%positive%]+" + this.m.Stacks + "[/color] Resolve"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=%positive%]+" + this.m.Stacks + "[/color] Initiative"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/damage_received.png",
					text = "[color=%negative%]-" + ((::Math.minf(0.7, 0.02 * this.m.Stacks)) * 100) + "%[/color] Damage received"
				}
			]);
		}

		return tooltip;
	}

	o.addRage = function (_r) {
		this.m.Stacks = ::Math.min(this.m.Stacks + _r, 15);
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer()) {
			this.spawnIcon("status_effect_143", actor.getTile());
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}
	}

	o.onUpdate = function (_properties) {
		_properties.DamageReceivedTotalMult *= ::Math.maxf(0.3, 1.0 - 0.02 * this.m.Stacks);
		_properties.Bravery += this.m.Stacks;
		_properties.DamageRegularMin += this.m.Stacks;
		_properties.DamageRegularMax += this.m.Stacks;
		_properties.Initiative += this.m.Stacks;
	}

	o.onTurnEnd = function () {
		this.m.Stacks = this.Math.max(0, this.m.Stacks - 1);
	}

	o.onCombatStarted = function () {
		this.m.SkillCount = 0;
		this.m.Stacks = 0;
	}

	o.onCombatFinished = function () {
		this.m.SkillCount = 0;
		this.m.Stacks = 0;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon(["damage_dealt", "bravery", "initiative"]) + ", [color=%negative%]-" + ((::Math.minf(0.7, 0.02 * this.m.Stacks)) * 100) + "%[/color]" + ::Legends.S.inlineIcon("damage_received");
	}
});
