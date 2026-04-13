::mods_hookExactClass("skills/actives/crush_armor", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "Using the weapon to batter, deform, rip and otherwise render the target\'s armor unusable with great effect. Although the impact will be felt through the thickest of armor, it won\'t greatly injure the wearer.";
	}

	o.getTooltip = function()
	{
		local p = this.factoringOffhand(this.getContainer().buildPropertiesForUse(this, null));
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local tooltip = this.getDefaultUtilityTooltip();

		if (damage_armor_max > 0)
		{
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damage_armor_min + "[/color] - [color=%damage%]" + damage_armor_max + "[/color] damage to armor"
			});
		}

		if (p.DamageMinimum > 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Always inflicts at least [color=%damage%]" + p.DamageMinimum + "[/color] damage to hitpoints, regardless of armor"
			});
		}
		return tooltip;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 2.0 : 1.5;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum += 10;
		}
	}
});
