::mods_hookExactClass("events/events/witchhunter_ghoul_teeth_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%witchunter% the witch hunter comes to you with a vial of unknown liquid.%SPEECH_ON%Anti-poison.%SPEECH_OFF%%They_witchunter% explains. %They_witchunter% pops the cork off and gives you a smell. There\'s a strong scent of piss. %They_witchunter% nods.%SPEECH_ON%Aye, it\'s wretched, but you need the wretched to fight the wretched, and a goblin\'s poison is a real wretched matter to contend with. But this will help.%SPEECH_OFF%";
			}
		}
	}
})
