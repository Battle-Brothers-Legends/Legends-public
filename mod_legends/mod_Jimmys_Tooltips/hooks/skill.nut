// add MSU custom events for all primary deffensive perks
// this `addEvent` should never be inside a hook
::MSU.Skills.addEvent("onOtherActorTooltip", function(_tooltip, _targetActor){}, true, true);

::ModJimmysTooltips.ModHook.hook("scripts/skills/skill", function(q){

	q.noDescriptionDefaultTooltip <- function( startID ){
		local ret = [], p = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, null));
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMinMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMaxMult);
		local damage_direct_min = this.Math.floor(damage_regular_min * this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd))));
		local damage_direct_max = this.Math.floor(damage_regular_max * this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + (this.m.IsRanged ? p.DamageDirectRangedAdd : p.DamageDirectMeleeAdd))));
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMinMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * (this.m.IsRanged ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMaxMult);


		if (this.m.Container.getActor().getSkills().hasTrait(::Legends.Trait.OathOfHonor) && (this.m.IsWeaponSkill && this.m.IsRanged || this.m.IsOffensiveToolSkill))
		{
			ret.push({
				id = startID + 4,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character has taken an oath precluding the use of ranged weapons or tools[/color]"
			});
			return ret;
		}

		if (this.m.DirectDamageMult == 1.0)
		{
			ret.push({
				id = startID,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=%damage%]" + damage_direct_min + "[/color] - [color=%damage%]" + damage_direct_max + "[/color] damage that ignores armor"
			});
		}
		else if (this.m.DirectDamageMult > 0.0)
		{
			ret.push({
				id = startID + 1,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=%damage%]" + damage_regular_min + "[/color] - [color=%damage%]" + damage_regular_max + "[/color] damage to hitpoints, of which [color=%damage%]0[/color] - [color=%damage%]" + damage_direct_max + "[/color] can ignore armor"
			});
		}
		else
		{
			ret.push({
				id = startID + 2,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=%damage%]" + damage_regular_min + "[/color] - [color=%damage%]" + damage_regular_max + "[/color] damage to hitpoints"
			});
		}

		if (damage_armor_max > 0)
		{
			ret.push({
				id = startID + 3,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damage_armor_min + "[/color] - [color=%damage%]" + damage_armor_max + "[/color] damage to armor"
			});
		}

		return ret;
	}

});
