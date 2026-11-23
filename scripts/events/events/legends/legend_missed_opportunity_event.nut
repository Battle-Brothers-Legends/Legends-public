this.legend_missed_opportunity_event <- this.inherit("scripts/events/event", {
	m = {
		isValidForEncounter = false,
		Score = 0
	},

	function create() {
		this.m.ID = "event.legend_missed_opportunity";
		this.m.Title = "A Missed Opportunity";
		this.m.Cooldown = 0;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_71.png[/img]{A sudden, chilling sensation washes over you, like a thread of destiny snapping cleanly in the dark.\n\nThe familiar sights and sounds of the town vanish in an instant. In their place, a grand thoroughfare materializes, teeming with vividly-cloaked nobility, armored guards wearing suits of segmented iron, shackled slaves, and wealthy merchants - all draped in strange finery, going about their daily routines.\n\nFor a fleeting second you feel at peace, only to be choked out by an overwhelming feeling of foreboding. You nervously look around searching the crowds for the familiar faces of your mercenaries, but they are nowhere to be seen.\n\nYou close your eyes.\n\nWhen you open them again, the street is once again dull and ordinary. The only thing left of the witnessed grandiosity is a frustrating feeling of a missed opportunity. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
					{
						Text = "Damn. I was sure something important was about to happen.",
						getResult = function (_encounter) {
							return 0;
						}
					}
				],

			function start(_event) {}
		});
	}

	function onUpdateScore() {}

	function onDetermineStartScreen() {
		return "A";
	}
});
