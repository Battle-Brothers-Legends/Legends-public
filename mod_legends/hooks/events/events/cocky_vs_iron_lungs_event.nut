::mods_hookExactClass("events/events/cocky_vs_iron_lungs_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]As you roll up some maps and put them back in their panniers, a commotion draws you outside your tent. The men are dragging %cocky% across the ground. %Their_cocky% clothes are sopping wet and %their_cocky% face one shade short of death. The mercenaries give %them_cocky% some good slaps on the cheeks. Eventually, %they_cocky% wakes up, eyes wild, mouth gargling water like a broken fountain. %They_cocky% looks around and asks what you, too, wish to know.%SPEECH_ON%What happened?%SPEECH_OFF%%ironlungs% walks over, a similarly wet visage, but with a far more colorful complexion.%SPEECH_ON%You cocky cunt dared to see which of us could hold their breath the longest. You lost because they don\'t call these the iron lungs for nuttin\'.%SPEECH_OFF%The company have a laugh as %ironlungs% boastfully pounds %their_ironlungs% chest. %cocky%, still wobbly, gets to %their_cocky% feet. Mere moments after being completely unconscious, %they_cocky%\'s already back to %their_cocky% prideful ways.%SPEECH_ON%Yeah yeah, you bested me this day, but I shall be the best, just you wait!%SPEECH_OFF%Another sellsword whimsically points out that the cocksure fella has a huge string of snot dangling from %their_cocky% nose. %They_cocky% confidently wipes it away despite the roaring laughter of the company.";
			}
		}
	}
});
