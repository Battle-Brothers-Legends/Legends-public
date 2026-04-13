::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.m.NimbleThreshold <- 15;
	o.m.SteepnessFactor <- 1.5;

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local fm = this.Math.ceil(this.getArmorReductionMult() * 100);
		local tooltip = getTooltip();

		if (fm < 100 && this.getContainer().hasPerk(::Legends.Perk.Relentless))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=%positive%]" + fm + "%[/color] of any damage to armor from attacks"
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

	o.getArmorReductionMult <- @() (1 - (1 - this.getChance()) / 3);

	local onBeforeDamageReceived = o.onBeforeDamageReceived;
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties );
		if (this.getContainer().hasPerk(::Legends.Perk.Relentless))
			_properties.DamageReceivedArmorMult *= this.getArmorReductionMult();
	}

	// local onBeforeDamageReceived = o.onBeforeDamageReceived;
	// o.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	// {
	// 	onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties );

	// 	_properties.DamageReceivedArmorMult *= (1 - (1 - this.getChance()) / 6);
	// }
});
