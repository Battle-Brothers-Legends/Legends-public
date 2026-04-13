::mods_hookExactClass("events/events/dlc8/anatomist_dissects_beetles_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_184.png[/img]{You find %anatomist% crouching over a piece of log. %They_anatomist%\'s got a trio of beetles laid out. One has a needle pinning it to the wood, its little legs pedaling haplessly in the air. Another is nothing but a bodied husk, its legs removed and set beside it. The last is in a small tin of water with a stone weighing it down. %anatomist% shakes %them_anatomist% head.%SPEECH_ON%The duress these creatures can undergo is quite impressive. Physical damage does not allude to destruction as it does with us. Take these three, for example: pierced, dismembered, and drowning. Yet they all live. The efficiency is something else, wouldn\'t you agree?%SPEECH_OFF%Sure. You ask him where %they_anatomist% even got all those beetles. %They_anatomist% shrugs.%SPEECH_ON%They crawl all over us when we\'re sleeping. I just happen to stay up to catch them in the act. This underwater one, for example, I caught pecking at your ear opening.%SPEECH_OFF%You tell him to continue %them_anatomist% research and to capture as many beetles as %they_anatomist% can.}";
			}
		}
	}
});
