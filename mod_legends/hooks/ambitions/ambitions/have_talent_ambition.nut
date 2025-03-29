::mods_hookExactClass("ambitions/ambitions/have_talent_ambition", function(o) 
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.TooltipText = "Have a character in your roster with a three stars talent at three different attributes. Travel the land and seek the best of the best. Consider buying the \'Pre signed contracts\' equipment for your retinue.";
	}

});
