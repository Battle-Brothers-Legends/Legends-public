::mods_hookExactClass("skills/traits/cultist_zealot_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is a zealous follower of Davkul, so much so that they have come to embrace physical pain as bringing them closer to salvation.";
	}
});
