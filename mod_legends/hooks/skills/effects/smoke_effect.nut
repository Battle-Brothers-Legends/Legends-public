::mods_hookExactClass("skills/effects/smoke_effect", function (o) {
	o.getDescription = function () {
		return "Covered by dense layers of smoke, slipping in and out of visibility, moving freely and ignoring any zones of control.";
	}

	o.getTooltip = function () {
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
				id = 11,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = "[color=%negative%]50%[/color] less Ranged Damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-10[/color] Vision"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by Zones of Control and will hide you"
			}
		];
	}

	o.onAdded <- function () {
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		actor.getSkills().add(::new("scripts/skills/terrain/hidden_effect"));
		properties.Vision -= 10;
		actor.updateVisibility(actor.getTile(), actor.getCurrentProperties().getVision(), actor.getFaction());
		actor.setDirty(true);
	};

	o.onRemoved <- function () {
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		properties.Vision += 10;
		actor.updateVisibility(actor.getTile(), actor.getCurrentProperties().getVision(), actor.getFaction());
		actor.setDirty(true);
	};

	o.onMovementFinished <- function (_tile) {
		if (_tile.Properties.Effect == null || _tile.Properties.Effect.Type != "smoke") {
			this.removeSelf();
		}
	};

	o.onUpdate = function (_properties) {
		local actor = this.getContainer().getActor();
		local tile = actor.getTile();
		if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "smoke") {
			_properties.RangedSkillMult *= 0.5;
			_properties.DamageReceivedRangedMult *= 0.5;
			_properties.Vision -= 10;
		} else {
			this.removeSelf();
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10[/color] " + ::Legends.S.inlineIcon("vision") + ", [color=%negative%]-50%[/color] ranged " + ::Legends.S.inlineIcon("damage_received") + ", unaffected by Zones of Control";
	}
});
