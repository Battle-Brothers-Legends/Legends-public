::mods_hookExactClass("events/events/dlc2/nightowl_catches_thief_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_33.png[/img]{Waking from a strange dream, you step out of your tent to find most of the company asleep, aside from the night owl %nightowl%. %They_nightowl%\'s at the edge of the camp with %their_nightowl% back turned, but %they_nightowl% seems to hear you approaching and speaks without looking.%SPEECH_ON%This is how it starts, captain. The rage. The fever. That turns good men, hoooo.%SPEECH_OFF%%They_nightowl% wheels around to show off an actual owl %they_nightowl% has caught. Its eyelids are half-closed, probably worn out from escaping and now simply humiliated at being caught without any carnivorous purpose. You ask %nightowl% how the hell %they_nightowl% caught it. The sellsword lets the bird go and shrugs.%SPEECH_ON%With my hands. I also caught this.%SPEECH_OFF%%They_nightowl% crouches and pulls up a heretofore unseen corpse.%SPEECH_ON%Slick little thief. I happened upon him, eh, discounting our wares so to speak. I was a little too tired to talk, so I let my blade here tell him the shop\'s closed. I then followed his footsteps out to where he came from and found his, eh, let\'s say accoutrements.%SPEECH_OFF%You nod. Right. Of course. You tell the %person_nightowl% you\'re going back to sleep and you\'ll make judgments of %their_nightowl% doings in the morning. %They_nightowl% nods back.%SPEECH_ON%Right captain. I\'ll try and get some shuteye myself. Been a couple days. Or was it weeks?%SPEECH_OFF%}";
		});
	}
});
