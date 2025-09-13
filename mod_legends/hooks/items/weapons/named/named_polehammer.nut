::mods_hookExactClass("items/weapons/named/named_polehammer", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [ [3, 7] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Stun Chance"
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor, function (_skill) {
			_skill.m.FatigueCost = 35;
			_skill.m.ActionPointCost = 6;
			_skill.m.Icon = "skills/legend_active_pry_armor_polehammer.png";
			_skill.m.IconDisabled = "skills/legend_active_pry_armor_polehammer_bw.png";
			_skill.m.Overlay = "active_legend_pry_armor_polehammer";
		});
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}
});
