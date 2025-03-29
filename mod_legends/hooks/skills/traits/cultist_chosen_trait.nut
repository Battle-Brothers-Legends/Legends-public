::mods_hookExactClass("skills/traits/cultist_chosen_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character feels chosen by Davkul, something not many in this world can claim. They embrace physical pain and peril as bringing them closer to salvation, and they believe that their god will protect, so they can act on behest of their god.";
	}
});
