::mods_hookExactClass("items/weapons/named/named_flail", function (o) {
	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_flail_effect"];
	o.m.EffectBounds <- [
		[100, 100]
	];
	o.m.EffectTooltip <- {
		Text = @(_item)"[color=%positive%]100%[/color] chance to Daze a target on a hit to the head",
		Icon = "ui/icons/chance_to_hit_head.png"
	};

	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Cultist;
	}

	o.randomizeValues <- function () {
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;

		this.named_weapon.randomizeValues();
	}
});
