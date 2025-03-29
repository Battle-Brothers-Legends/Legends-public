::mods_hookExactClass("skills/traits/cultist_prophet_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is a prophet of Davkul, the fleshen conduit of his will and the earthen voice speaking his truth. Other believers listen to every word and feel compelled to go above and beyond their physical limits at the behest of this character.";
	}
});
