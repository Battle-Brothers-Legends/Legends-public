::mods_hookExactClass("skills/perks/perk_nimble", function (o) {
	o.m.NimbleThreshold <- 15;
	o.m.SteepnessFactor <- 1.5;

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	o.getDynamicTooltip <- function (_actor = null) {
		local tooltip = [];
		local actor = _actor != null ? _actor : this.getContainer().getActor();

		local fm = ::Math.round(this.getChance(actor) * 100);
		if (fm < 100) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Only receive [color=%positive%]" + fm + "%[/color] of any damage to hitpoints from attacks"
			});
		} else {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]This character\'s body and head armor are too heavy as to gain any benefit from being Nimble[/color]"
			});
		}

		fm = ::Math.ceil(this.getArmorReductionMult(actor) * 100);
		if (fm < 100 && ::Legends.Perks.has(actor, ::Legends.Perk.Relentless)) {
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/armor_damage_received.png",
				text = "Only receive [color=%positive%]" + fm + "%[/color] of any damage to armor from attacks"
			});
		}
		return tooltip;
	}

	o.getChance = function (_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local fat = 0;

		local body = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local head = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);

		if (body != null) {
			fat = fat + body.getStaminaModifier();
		}

		if (head != null) {
			fat = fat + head.getStaminaModifier();
		}

		fat = ::Math.min(0, fat + this.m.NimbleThreshold);
		local ret = ::Math.minf(1.0, 1.0 - 0.6 + ::Math.pow(::Math.abs(fat), this.m.SteepnessFactor) * 0.01);
		return ret;
	}

	o.getArmorReductionMult <- @(_actor = null)(1 - (1 - this.getChance(_actor)) / 3);

	local onBeforeDamageReceived = o.onBeforeDamageReceived;
	o.onBeforeDamageReceived = function (_attacker, _skill, _hitInfo, _properties) {
		onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties);
		if (this.getContainer().hasPerk(::Legends.Perk.Relentless)) {
			_properties.DamageReceivedArmorMult *= this.getArmorReductionMult();
		}
	}

	// local onBeforeDamageReceived = o.onBeforeDamageReceived;
	// o.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	// {
	// 	onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties );

	// 	_properties.DamageReceivedArmorMult *= (1 - (1 - this.getChance()) / 6);
	// }

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		local tooltip = "[color=%negative%]-" + (1.0 - this.getChance()) * 100 + "%[/color] " + ::Legends.S.inlineIcon("damage_received");
		if (::Legends.Perks.has(this, ::Legends.Perk.Relentless)) {
			tooltip += ", [color=%negative%]-" + (1.0 - this.getArmorReductionMult()) * 100 + "%[/color] " + ::Legends.S.inlineIcon("armor_damage_received");
		}
		return tooltip;
	}
});
