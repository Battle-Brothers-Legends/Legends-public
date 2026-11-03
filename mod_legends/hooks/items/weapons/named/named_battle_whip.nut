::mods_hookExactClass("items/weapons/named/named_battle_whip", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_whip_bleed_effect", "scripts/skills/effects/legend_named_whip_feint_effect"];
	o.m.EffectBounds <- [ [30, 50], [20, 35] ];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] to apply "+ (_item.m.PossibleEffectIdx == 0 ? "Bleeding" : "Parried") + " to the Target on Hit" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/chance_to_hit_head.png"
	};

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Categories = "Cleaver/Whip, One-Handed";
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendWhipDebilitate);
	}
});
