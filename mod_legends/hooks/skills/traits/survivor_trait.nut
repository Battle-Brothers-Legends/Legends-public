::mods_hookExactClass("skills/traits/survivor_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Why won\'t you just stay dead? This character is a survivor and will outlive most of their peers.";
	}
});
