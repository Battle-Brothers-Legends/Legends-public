::mods_hookExactClass("ambitions/ambitions/named_item_set_ambition", function(o) 
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]After weeks spent listening for rumors, buying pints of beer for decrepit old veterans, and negotiating with wheedling crones, you were able to ferret out the locations of a prestigious weapon, shield, armor and helmet. Having learned where to find the pieces, all that remained was the minor matter of defeating the various horrors and cutthroats guarding it. Now soon to be worn by the men of your company, the pieces form a set fearsome to behold. %SPEECH_ON%The man who dons this armament on the battlefield will see the fiercest enemy hobble away shaking a load down the leg of his pants!%SPEECH_OFF%%randombrother% exclaims proudly and to the laughing approval of his brothers in arms. You only hope their joy and excitement doesn\'t turn into envy once you announce which man will get to wear the pieces.";
	}

});
