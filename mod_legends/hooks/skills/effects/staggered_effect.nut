::mods_hookExactClass("skills/effects/staggered_effect", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.Staggered);
	}

	o.getDescription = function () {
		return "Received a heavy blow, off-balance, scrambling and late to act.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-50%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.5;
	}

	local onAdded = o.onAdded;
	o.onAdded = function () {
		local actor = this.getContainer().getActor();
		if (actor.getFlags().get("CanNotBeStaggered") || !actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded()) {
			this.removeSelf();
			return;
		}
		this.m.Overlay = "status_effect_65";
		this.spawnIcon(this.m.Overlay, actor.getTile());
		onAdded();
	}

	o.onRefresh = function () {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		::Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
		local tile = this.getContainer().getActor().getTile();
		if (tile != null) {
			this.spawnIcon("status_effect_65", this.getContainer().getActor().getTile());
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
