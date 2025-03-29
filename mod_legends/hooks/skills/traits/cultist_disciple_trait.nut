::mods_hookExactClass("skills/traits/cultist_disciple_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is a disciple of Davkul, an individual with unquestionable loyalty to the elder god. They embrace physical pain and peril as bringing them closer to salvation.";
	}
});
