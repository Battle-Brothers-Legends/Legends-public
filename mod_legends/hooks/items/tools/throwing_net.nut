::mods_hookExactClass("items/tools/throwing_net", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ItemType = this.Const.Items.ItemType.Tool | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.Net;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetCasting))
		{
			this.m.RangeMax = 5;
		}
	}

	o.isAmountShown <- function ()
	{
		return true;
	}

	o.onUpdateProperties <- function ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair))
		{
			_properties.Stamina -= this.m.StaminaModifier;
		}
	}

	// Bag fatigue uses getStaminaModifier
	o.getStaminaModifier <- function ()
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair))
		{
			return 0;
		}
		else
		{
			return this.m.StaminaModifier;
		}
	}
});
