::mods_hookExactClass("items/weapons/named/named_fencing_sword", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_fencing_sword_effect"];
	o.m.EffectBounds <- [
		[4, 12]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]+" + _item.m.EffectChanceOrBonus + "%[/color] Initiative" + ::Legends.Items.Named.getRangeOfSpecialEffect(_item),
		Icon = "ui/icons/chance_to_hit_head.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.randomizeValues <- function () {
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;

		this.named_weapon.randomizeValues();
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
	}
});
