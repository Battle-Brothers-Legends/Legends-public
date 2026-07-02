::mods_hookExactClass("items/weapons/named/named_shamshir", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_shamshir_effect"];
	o.m.EffectBounds <- [ [20, 35] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Slash, function (_skill)
			{
				_skill.m.IsShamshirSlash = true;
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
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
				text = "Lowered Injury Threshold by [color=%positive%]" + this.m.EffectChanceOrBonus + "%[/color]" + ::Legends.Weapons.Named.getRangeOfSpecialEffect(this)
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDebilitate);
	}
});
