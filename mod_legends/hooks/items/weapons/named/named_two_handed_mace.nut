::mods_hookExactClass("items/weapons/named/named_two_handed_mace", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_mace_stagger_effect"];
	o.m.EffectBounds <- [
		[15, 25]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Stagger Chance" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/special.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Value = 3400;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}
});
