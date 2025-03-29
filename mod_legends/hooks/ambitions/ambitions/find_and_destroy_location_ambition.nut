::mods_hookExactClass("ambitions/ambitions/find_and_destroy_location_ambition", function(o) 
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_65.png[/img]It sounded like a good idea at the time, but tramping around the wilderness without a map or any destination in mind turned out to be quite a strenuous way to find riches, or even a battle. Your footsore band did eventually come upon a worthy target though, and everyone had to agree the venture was worthwhile after all. %farmer% is almost glowing with satisfaction as they survey the few remaining embers of the %recently_destroyed%.%SPEECH_ON%They hadn\'t the merest clue we were coming. Like wheat before our scythes, brothers!%SPEECH_OFF%%notfarmer% raises an eyebrow.%SPEECH_ON%Speak for yourself. I\'m no farmer.%SPEECH_OFF%";
	}

});
