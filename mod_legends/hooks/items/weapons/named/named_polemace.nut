::mods_hookExactClass("items/weapons/named/named_polemace", function (o) {
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
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = ::Const.Items.WeaponType.Mace | ::Const.Items.WeaponType.Polearm;
		this.setCategories("Mace/Polearm, Two-Handed");
	}
});
