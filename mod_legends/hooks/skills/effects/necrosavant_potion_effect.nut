::mods_hookExactClass("skills/effects/necrosavant_potion_effect", function (o) {
	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) {
			return;
		}

		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Heal [color=%positive%]25%[/color] of health " + ::Legends.S.inlineIcon("damage_dealt") + " to adjacent enemies that have blood";
	}
});
