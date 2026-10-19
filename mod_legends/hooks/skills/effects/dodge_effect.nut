::mods_hookExactClass("skills/effects/dodge_effect", function (o) {
	o.m.NormalBonus <- false;
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Quick reflexes allow this character to add part of %their% current Initiative to melee and ranged defense.";
		this.m.IsRemovedAfterBattle = false;
		this.m.IsSerialized = false;
	}

	o.getTooltip = function () {
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Ranged Defense"
			}
		]);
		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function (_properties) {
		if (!this.m.NormalBonus) {
			return onAfterUpdate(_properties);
		}
		_properties.MeleeDefense += this.getBonus();
		_properties.RangedDefense += this.getBonus();
	}

	o.getBonus <- function () {
		local actor = this.getContainer().getActor();
		local bonus = ::Math.maxf(1.0, ::Math.minf(2.0, 2.0 - (actor.getHitpointsMax().tofloat() - 50.0) / 50.0));
		return ::Math.floor(actor.getInitiative() * bonus * 0.15);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.getBonus() + "[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]);
	}
});
