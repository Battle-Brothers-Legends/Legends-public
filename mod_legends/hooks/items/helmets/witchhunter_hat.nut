::mods_hookExactClass("items/helmets/witchhunter_hat", function(o) {
	o.getTooltip <- function () {
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Wearer is not affected by night penalties"
		});
		return result;
	}

	o.onUpdateProperties <- function( _properties ) {
		local staminaMult = 1.0;

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Brawny))
			staminaMult = 0.75;
		_properties.Armor[::Const.BodyPart.Head] += this.m.Condition;
		_properties.ArmorMax[::Const.BodyPart.Head] += this.m.ConditionMax;
		_properties.Stamina += ::Math.ceil(this.m.StaminaModifier * staminaMult);
		_properties.Vision += this.getVision();
		_properties.IsAffectedByNight = false;
	}
});
