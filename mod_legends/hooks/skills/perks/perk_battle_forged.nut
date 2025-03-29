::mods_hookExactClass("skills/perks/perk_battle_forged", function(o) {
	o.m.ArmorPercentageAsReduction <- 5;

	o.isHidden = function()
	{
		return this.getReductionPercentage() <= 0;
	}

	o.getDescription = function()
	{
		return "Specialize in heavy armor! Armor damage taken is reduced by a percentage equal to [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.ArmorPercentageAsReduction + "[/color] of the current total armor value of both body and head armor. The heavier your armor and helmet, the more you benefit.";
	}
	
	o.getReductionPercentage <- function()
	{
		local armor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Head) + this.getContainer().getActor().getArmor(this.Const.BodyPart.Body);
		return this.Math.floor(armor * this.m.ArmorPercentageAsReduction * 0.01);
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + (100 - this.getReductionPercentage()) + "%[/color] of any damage to armor from attacks"
		});

		return tooltip;
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill != null && !_skill.isAttack()) return;
		
		_properties.DamageReceivedArmorMult *= 1.0 - this.getReductionPercentage() * 0.01;
	}
});