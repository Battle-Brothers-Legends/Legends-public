::mods_hookExactClass("skills/actives/debilitate", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "skills/debilitate_square.png";
		this.m.IconDisabled = "skills/debilitate_square_bw.png";
		this.m.FatigueCost = 10;
	}

	o.getDescription = function ()
	{
		return "Prepare your next attack to debilitate a target for one turn, reducing their ability to inflict damage by [color=%negative%]-25%[/color] and increasing the damage they take by [color=%positive%]-15%[/color]. Missing the target will waste the effect.";
	}
});
