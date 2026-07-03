::mods_hookExactClass("items/weapons/named/named_estoc", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_estoc_effect"];
	o.m.EffectBounds <- [ [2, 7] ];

	local create = o.create;
	o.create = function () {
		create();
		this.m.IsAgainstShields = false;
		this.m.ShieldDamage = 0;
		this.m.Variants = [1,2,3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.EstocStab);
		::Legends.Actives.grant(this, ::Legends.Active.Perforate);
		::Legends.Actives.grant(this, ::Legends.Active.Skewer);
	}
});
