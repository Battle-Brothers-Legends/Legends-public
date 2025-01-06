::mods_hookExactClass("items/weapons/named/named_polehammer", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_hammer_stun_effect"];
	o.m.EffectBounds <- [ [3, 7] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
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

	o.addSkill <- function( _skill )
	{
		this.named_weapon.addSkill(_skill);

		if (_skill.getID() != "actives.batter")
			return;

		local skill = ::new("scripts/skills/actives/impale");
		skill.m.Icon = "skills/legend_halberd_impale.png";
		skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
		skill.m.Overlay = "legend_halberd_impale";
		skill.m.IsIgnoredAsAOO = true;
		named_weapon.addSkill(skill);
	}
});
