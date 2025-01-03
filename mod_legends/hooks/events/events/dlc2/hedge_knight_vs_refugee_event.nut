::mods_hookExactClass("events/events/dlc2/hedge_knight_vs_refugee_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_52.png[/img]%hedgeknight% the hedge knight walks up to an eating %refugee%. The former refugee sees the shadow looming and slowly turns about.%SPEECH_ON%Yeah?%SPEECH_OFF%The hedge knight snorts and spits a loogie about the size of a baby\'s arm. Snorting again.%SPEECH_ON%You ran from your home. You watched it burn and put yer back to the flames rather than fight them. This company is your home now. What stops you from running from the fire now?%SPEECH_OFF%";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_52.png[/img]You step forward and tell the hedge knight to stuff it. The company ain\'t here to stroke egos. Laughing, the bear of a mercenary steps off.%SPEECH_ON%As you say, sir. Wouldn\'t want to get into a scrap with the company princess.%SPEECH_OFF%The company laughs, but the refugee only stares into their bowl of food like someone\'d just spat in it.";
				local startB = s.start;
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					startB(_event);
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]You don\'t intervene. The hedge knight continues.%SPEECH_ON%I\'ve no pity for your pain. You understand?%SPEECH_OFF%Nodding, the refugee looks up.%SPEECH_ON%Aye, but what pity does anyone have for yours?%SPEECH_OFF%%refugee%\'s arm shoots forward so fast it flips the plate into the campfire. The fork sticks in the thigh of %hedgeknight% and %refugee% can\'t wrench it out no better than if it were stuck in a trunk of oak. The hedge knight grits and falls, flattening the refugee. The knight\'s giant hands press the refugee\'s skull into the earth until the poor sellsword\'s breathing dirt. The rest of the company stands up and backs off. You step forward, but %hedgeknight% holds a hand out before standing back up.%SPEECH_ON%Alright, little runner, alright. You\'ve fight in you yet.%SPEECH_OFF%He retrieves the fork and holds it out. A drop of blood grooves between he tines.%SPEECH_ON%Whatcha eating? Oh yeah? Good. I\'ll double it with my portion. Come and sit.%SPEECH_OFF%";
				local startC = s.start;
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					startC(_event);
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_80.png[/img]%streetrat% steps forward and points a finger at the hedge knight.%SPEECH_ON%You ain\'t got a lick of understanding of no flame nor fire.%SPEECH_OFF%Laughing, %hedgeknight% turns around and cracks huge knuckles.%SPEECH_ON%Course I do. I AM the fire.%SPEECH_OFF%The lowborn\'s arms are defiantly crossed.%SPEECH_ON%And we ain\'t the ash, but the wood itself. You\'re a whore for the noblemen, that\'s what you truly are. They pay you a high price and you go on with your strength and cruelty and do what they tell you to do. Like... like a whore...%SPEECH_OFF%Another sellsword holds up a finger.%SPEECH_ON%I think yer describing us in general. We\'re mercenaries.%SPEECH_OFF%And another adds.%SPEECH_ON%Did you just compare yerself to kindling?%SPEECH_OFF%%streetrat% rubs the back of his head.%SPEECH_ON%Yeah I\'m gonna be honest the hedge knight scared me a bit there and I lost what I was going to say.%SPEECH_OFF%The company looks around before bursting into laughter and whatever animosity there was is gone.";
				local startD = s.start;
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					startD(_event);
				}
			}
		}
	}
});
