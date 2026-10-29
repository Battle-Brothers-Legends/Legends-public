this.perk_legend_immovable_object <- this.inherit("scripts/skills/skill", {
	m = {
		isGrantingStunImmunity = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendImmovableObject);
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return -0.1 * actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head,
			::Const.ItemSlot.Mainhand,
			::Const.ItemSlot.Offhand,
			::Const.ItemSlot.Bag,
			::Const.ItemSlot.Accessory
		]);
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.Bravery += ::Math.floor(bonus);
		_properties.DamageReceivedDirectMult *= 1.0 - 0.01 * bonus;
		this.m.isGrantingStunImmunity = bonus >= 5;
		if (bonus >= 8 && ::Legends.Perks.has(this, ::Legends.Perk.SteelBrow)) {
			_properties.IsImmuneToKnockBackAndGrab = true;
		}
	}

	function getDynamicTooltip(_actor = null) {
		local bonus = this.getBonus(_actor);
		local tooltip = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/icon_locked.png",
				text = "Current Weight: [color=%positive%]" + bonus * 10 + "[/color]"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + ::Math.floor(bonus) + "[/color] Resolve"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%positive%]" + ::Math.round(100 * ((1.0 - 0.01 * bonus))) + "%[/color] Direct Damage received"
			}
		];
		if (bonus >= 5) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/immunity.png",
				text = "Incoming Stuns are reduced to Dazes"
			});
		}
		if (bonus >= 8 && ::Legends.Perks.has(_actor, ::Legends.Perk.SteelBrow)) {
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/immunity.png",
				text = "Immune to knockback and grab"
			});
		}
		return tooltip;
	}
});
