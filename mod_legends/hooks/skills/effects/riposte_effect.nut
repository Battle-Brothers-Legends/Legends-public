::mods_hookExactClass("skills/effects/riposte_effect", function (o) {
	o.m.TurnsLeft <- 1;

	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.Riposte);
	}

	o.getDescription = function () {
		return "Prepared to immediately counter-attack on any failed attempt to attack %them% in melee.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Counter-attacks on any missed melee attack"
			}
		]);
		return tooltip;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item != null && item.isWeaponType(::Const.Items.WeaponType.Staff)) {
			if (!actor.getCurrentProperties().IsSpecializedInPolearms) {
				_properties.MeleeSkill -= 10;
			}
		} else {
			onAnySkillUsed(_skill, _targetEntity, _properties);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Counter-attacks on any missed melee attack";
	}
});
