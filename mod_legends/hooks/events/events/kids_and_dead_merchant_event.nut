::mods_hookExactClass("events/events/kids_and_dead_merchant_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				})
			}
			if (s.ID == "HedgeKnight") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]%hedgeknight% steps forward and heaves a weapon to the fore, waving it at all the kids.%SPEECH_ON%Ah, so you want to be little bandits or heroes or some such shit? Well, that\'s good. That\'s fine. But I\'ll be watching to see who throws the first stone. He, or she, who does so will find out what happens when I get angry. And then after the rest of you have watched, I\'ll kill the lot of you. And I\'ll follow your little footprints all the way home, find your kin, and smash their farkin\' heads in.%SPEECH_OFF%The hedge knight pauses to glare about.%SPEECH_ON%So, which of you shall throw the first stone?%SPEECH_OFF%The tyke in charge of this miniature army raises his hand and speaks.%SPEECH_ON%Let them go. We\'ve better things to do than quarrel with these travelers.%SPEECH_OFF%Hey, that\'s a wise move. With pride-swallowing smarts like that the red-headed bugger might someday lead a company to great fortunes. But this day is yours. You take the merchant\'s goods and make your leave.";
			}
		}
	}
})
