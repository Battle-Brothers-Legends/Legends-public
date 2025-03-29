::mods_hookExactClass("skills/traits/drunkard_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "There\'s no question what this character spends their crowns on. Expect them to drink heavily before any battle, in secret if need be. ";
	}
});
