::mods_hookExactClass("skills/actives/decapitate", function(o)
{
	o.m.ApplyAxeMastery <- false;
	o.m.IsScytheDecapitate <- false;
	o.m.IsTwoHand <- false;

	o.setItem <- function (_item) {
		this.skill.setItem(_item);
		if (this.m.IsScytheDecapitate) {
			this.m.Description = "A devastating blow that can be used from behind the frontline, aimed to decapitate the target on the spot. Does more damage to hitpoints, the more the target is already wounded. Killing the target will always decapitate it, if at all possible.";
			this.m.MinRange = 1;
			this.m.MaxRange = 2;
			this.m.ActionPointCost = 6;
			this.m.FatigueCost = 30;
		}
		else if (this.m.IsTwoHand) {
			this.m.ActionPointCost = 6;
			this.m.DirectDamageMult = 0.30;
			this.m.FatigueCost = 30;
		}
	}

	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		ret.remove(3); // damage info shit
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));

		ret.insert(3, {
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=%damage%]" + damage_regular_min + "[/color] - [color=%damage%]" + damage_regular_max * 2 + "[/color] damage depending on how wounded the target already is, of which [color=%damage%]0[/color] - [color=%damage%]" + damage_direct_max + "[/color] can ignore armor"
		});
		if (!this.m.IsScytheDecapitate)
			return ret;

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2[/color] tiles"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		if (this.m.ApplyAxeMastery) {
			this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else if (this.m.IsScytheDecapitate) {
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
		}
		else {
			onAfterUpdate(_properties);
		}
	}
});
