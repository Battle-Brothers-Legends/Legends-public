::mods_hookExactClass("items/weapons/named/named_two_handed_hammer", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [
		[5, 10]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Stun Chance" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/special.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield)) {
			_skill.m.IsHammer = true;
		}
		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendObliterate);
	}
});
