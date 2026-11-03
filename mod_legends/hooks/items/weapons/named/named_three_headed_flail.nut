::mods_hookExactClass("items/weapons/named/named_three_headed_flail", function (o) {
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
		this.m.StaminaModifier = -14;
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Description = "An very rare weapon built from valuable and strong materials. Despite its ceremonial look it makes for a terrifying tool of destruction.";
	}
});
