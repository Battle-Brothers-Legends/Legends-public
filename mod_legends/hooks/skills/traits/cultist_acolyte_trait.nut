::mods_hookExactClass("skills/traits/cultist_acolyte_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character is an acolyte of Davkul, an individual with intimate knowledge of the teachings about the elder god. They embrace physical pain and peril as bringing them closer to salvation.";
	}
});
