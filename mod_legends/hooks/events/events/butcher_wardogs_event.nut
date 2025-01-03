::mods_hookExactClass("events/events/butcher_wardogs_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_27.png[/img]You open a crate of food to find the last of your reserves. An apple rolls across the bottom, sounding not unlike the grumble of an empty stomach as it totters about. A few loaves of bread give it some company and there is a piece of meat wrapped in a thick leaf. That\'s it.\n\nWhen you close the lid and turn around, %butcher% the butcher is standing there.%SPEECH_ON%Hey there boss. I see we got a problem. So how about I... fix it?%SPEECH_OFF%Just then, a thumb goes over the shoulder, right in the direction of two war dogs chained up to a stake.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_14.png[/img]The dogs are sitting rather studiously, panting and looking pretty content, so durable is their sense of happiness. But you\'ve mouths to feed and battles to fight. You give %butcher% the go ahead to do what is right for the company.\n\nThe butcher meanders toward the mutts, holding out one hand to pet them as the other clutches a hidden knife. You do not stick around to watch what happens next, but a short yelp quickly followed by another turns your already empty stomach.";
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.World.Assets.addMoralReputation(-2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
				}
			}
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
		}
	}
})
