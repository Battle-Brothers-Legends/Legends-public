::mods_hookExactClass("skills/traits/arena_fighter_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character has just dipped his toes into the brutal profession of arena fighting and did so without dying.";
	}
});
