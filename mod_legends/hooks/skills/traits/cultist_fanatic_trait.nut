::mods_hookExactClass("skills/traits/cultist_fanatic_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is a fanatic follower of Davkul, believing that Davkul embraces all in death.";
	}
});
