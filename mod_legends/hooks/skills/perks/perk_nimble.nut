::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.m.NimbleThreshold <- 15;
	o.m.SteepnessFactor <- 1.5;
	o.onUpdate <- function ( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.10; //10%
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local fm = this.Math.round(this.Math.round(this.getChance() / 6) * 100);
		local tooltip = getTooltip();

		if (fm < 100)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + fm + "%[/color] of any damage to hitpoints from attacks"
			});
		}

		return tooltip;
	}

	o.getChance = function ()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.min(0, fat + this.m.NimbleThreshold);
		local ret = this.Math.minf(1.0, 1.0 - 0.6 + this.Math.pow(this.Math.abs(fat), this.m.SteepnessFactor) * 0.01);
		return ret;
	}

	// local onBeforeDamageReceived = o.onBeforeDamageReceived;
	// o.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	// {
	// 	onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties );
		
	// 	_properties.DamageReceivedArmorMult *= (1 - (1 - this.getChance()) / 6);
	// }
});