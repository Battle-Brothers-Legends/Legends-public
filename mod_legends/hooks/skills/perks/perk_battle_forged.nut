::mods_hookExactClass("skills/perks/perk_battle_forged", function (o) {
	o.m.ArmorPercentageAsReduction <- 5;
	o.m.ReductionCapMax <- 80;

	o.isHidden = function () {
		return this.getReductionPercentage() <= 0;
	}

	o.getDescription = function () {
		return "Specialize in heavy armor! Armor damage taken is reduced by a percentage equal to [color=%positive%]" + this.m.ArmorPercentageAsReduction + "[/color] of the current total armor value of both body and head armor. The heavier your armor and helmet, the more you benefit.";
	}

	o.getReductionPercentage <- function (_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local armor = actor.getArmor(::Const.BodyPart.Head) + actor.getArmor(::Const.BodyPart.Body);
		return ::Math.min(this.m.ReductionCapMax, ::Math.floor(armor * this.m.ArmorPercentageAsReduction * 0.01));
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	o.getDynamicTooltip <- function (_actor = null) {
		return [
			{
				id = 6,
				type = "text",
				icon = "ui/icons/armor_damage_received.png",
				text = "Only receive [color=%positive%]" + (100 - this.getReductionPercentage(_actor)) + "%[/color] of any damage to armor from attacks"
			}
		];
	}

	o.onBeforeDamageReceived = function (_attacker, _skill, _hitInfo, _properties) {
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill != null && !_skill.isAttack()) {
			return;
		}

		_properties.DamageReceivedArmorMult *= 1.0 - this.getReductionPercentage() * 0.01;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + this.getReductionPercentage() + "%[/color] " + ::Legends.S.inlineIcon("armor_damage_received");
	}
});
