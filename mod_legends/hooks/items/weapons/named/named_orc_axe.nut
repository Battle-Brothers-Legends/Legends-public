::mods_hookExactClass("items/weapons/named/named_orc_axe", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_axe_effect"];
	o.m.EffectBounds <- [
		[15, 35]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Damage to Head" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/chance_to_hit_head.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.AmmoCost = 5;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
	}

	o.randomizeValues <- function () {
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.named_weapon.randomizeValues();
	}

	o.getAmmo <- function () {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function () {
		return this.m.AmmoMax;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendThrowBackupAxe);
	}
});
