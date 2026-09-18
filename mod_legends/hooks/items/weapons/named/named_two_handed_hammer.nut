::mods_hookExactClass("items/weapons/named/named_two_handed_hammer", function (o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [
		[5, 10]
	];

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
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
