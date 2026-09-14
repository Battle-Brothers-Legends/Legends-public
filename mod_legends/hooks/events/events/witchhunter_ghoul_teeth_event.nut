::mods_hookExactClass("events/events/witchhunter_ghoul_teeth_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]%witchhunter% the witch hunter comes to you with a vial of unknown liquid.%SPEECH_ON%Anti-poison.%SPEECH_OFF%%They_witchhunter% explains. %They_witchhunter% pops the cork off and gives you a smell. There\'s a strong scent of piss. %They_witchhunter% nods.%SPEECH_ON%Aye, it\'s wretched, but you need the wretched to fight the wretched, and a goblin\'s poison is a real wretched matter to contend with. But this will help.%SPEECH_OFF%";
		});
	}
})
