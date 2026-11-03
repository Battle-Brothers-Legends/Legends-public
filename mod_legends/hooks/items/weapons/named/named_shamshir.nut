::mods_hookExactClass("items/weapons/named/named_shamshir", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_shamshir_effect"];
	o.m.EffectBounds <- [
		[20, 35]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Lowered Injury Threshold" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/injury.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3, 4];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendFlowingSlash);
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDebilitate);
	}
});
