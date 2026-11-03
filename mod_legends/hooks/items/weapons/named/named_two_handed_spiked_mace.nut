::mods_hookExactClass("items/weapons/named/named_two_handed_spiked_mace", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_mace_stagger_effect"];
	o.m.EffectBounds <- [
		[15, 25]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Stagger Chance" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/special.png"
	};

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}
});
