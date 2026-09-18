::mods_hookExactClass("items/weapons/named/named_skullhammer", function (o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [
		[3, 7]
	];

	o.randomizeValues <- function () {
		this.m.StaminaModifier = -17;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;

		this.named_weapon.randomizeValues();
	}

	o.addSkill <- function (_skill) {
		this.weapon.addSkill(_skill);
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield)) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
			_skill.m.IsHammer = true;
		}
	}

	o.getTooltip <- function () {
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0) {
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+" + this.m.EffectChanceOrBonus + "%[/color] Stun Chance" + ::Legends.Items.Named.getRangeOfSpecialEffect(this)
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendObliterate);
	}
});
