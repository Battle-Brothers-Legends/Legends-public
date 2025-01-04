::mods_hookExactClass("events/events/swordmaster_teaches_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_17.png[/img]An old mercenary\'s voice is heard quietly issuing orders.%SPEECH_ON%The foot leads, the body follows. Again.%SPEECH_OFF%You find %swordmaster% the swordmaster and %swordstudent% practicing in a field. The elder\'s head shakes at the most recent display of swordsmanship.%SPEECH_ON%The foot leads, the body follows. Again!%SPEECH_OFF%The student practices what is taught. Nodding, the swordmaster barks another order.%SPEECH_ON%Now do it in reverse. The foot retreats, the body follows. Do not retreat with your mind. Let your feet do the thinking for you. Instinct is survival! Thinking is death! Move as though the world demanded it. If a wind blows are you faster than the leaves which hear its call? I see. Good... you are learning. Now... again.%SPEECH_OFF%";
			}
		}
	}
})
