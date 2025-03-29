::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.m.NimbleThreshold <- 15;
	o.m.SteepnessFactor <- 1.5;
	o.onUpdate <- function ( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.10; //10%
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
});