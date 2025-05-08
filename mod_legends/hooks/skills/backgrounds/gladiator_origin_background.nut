::mods_hookExactClass("skills/backgrounds/gladiator_origin_background", function(o)
{
	o.create = function ()
	{
		this.gladiator_background.create();
		this.m.DailyCost = 50;
		this.m.DailyCostMult = 1.0;
	}

	o.onAddEquipment = function ()
	{
	}

});
