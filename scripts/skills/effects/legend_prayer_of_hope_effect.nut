this.legend_prayer_of_hope_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Heal = 0,
		LastRoundApplied = 0,
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrayerOfHope);
		this.m.Description = "Blessed and infused with hope.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "This character will be healed [color=%positive%]" + this.m.Heal + "[/color] HP at the end of their turn"
			}
		]);
		return tooltip;
	}

	function setHeal(_v) {
		this.m.Heal = _v;
	}

	function applyEffect() {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = ::Time.getRound();
			this.spawnIcon(this.m.Overlay, actor.getTile());
			local toHeal = ::Math.min(10, this.m.Heal);
			if (actor.getHitpoints() < actor.getHitpointsMax()) {
				actor.setHitpoints(::Math.max(0, actor.getHitpoints() + toHeal));
			} else {
				this.removeSelf();
			}

			this.m.Heal -= toHeal;
			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.ceil(this.m.Heal / 10);
		this.applyEffect();
	}

	function onTurnEnd() {
		this.applyEffect();
	}

	function onWaitTurn() {
		this.applyEffect();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]" + this.m.Heal + "[/color] " + ::Legends.S.inlineIcon("health") + " healed at the end of the turn";
	}
});
