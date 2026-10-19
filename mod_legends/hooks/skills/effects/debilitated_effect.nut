::mods_hookExactClass("skills/effects/debilitated_effect", function (o) {
	o.m.TurnsLeft <- 3;

	o.getDescription <- function () {
		return "Severely weakened after having sustained a debilitating blow.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-25%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%positive%]+15%[/color] Damage received"
			}
		]);
		return tooltip;
	}

	o.getLogEntryOnAdded <- function (_user, _victim) {
		return _user + " has debilitated " + _victim;
	}

	o.onAdded <- function () {
		this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++this.m.TurnsLeft;
		}
	}

	o.onUpdate = function (_properties) {
		_properties.DamageTotalMult *= 0.75;
		_properties.DamageReceivedTotalMult *= 1.15;
	}

	o.onTurnEnd = function () {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", [color=%positive%]+15%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
