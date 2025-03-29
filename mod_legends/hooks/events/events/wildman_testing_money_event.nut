::mods_hookExactClass("events/events/wildman_testing_money_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]You find %wildman% the wildling stacking crowns into towers. %wildman% leans back from these moneyed manifestations with a wide grin, but then suddenly launches forward, knocking the towers over like a child would their blocks. %wildman% laughs maniacally as the coins scatter, seeing someone playing with money like this is a curious sight. Perhaps the wildling has no real conception of what crowns are good for? If so, maybe... maybe you could take them back?";
				s.Options[0].Text = "Let\'s see if %wildman% will trade it all away for something else.";
				s.Options[1].Text = "Better to leave the wildling crowns alone.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]You crouch down.%SPEECH_ON%Hey there %wildman%. Mind if I take one of these?%SPEECH_OFF%Carefully, you pick up a coin and measure the wildling\'s reaction. %wildman% shrugs and grunts as if to say \'it\'s yours\'. You take another crown. And then another. The wildling glares at you, but you slowly produce a stick with a frilly bow tied to the top. Its whirly nature captures the wildling\'s eye. When %wildman% reaches out for it, you draw it back and shake your head. You then point at the crowns, and then at the stick.%SPEECH_ON%One for the other, yes?%SPEECH_OFF%The wildman looks at the crowns, mulling them over like an accountant, but you know their thoughts are far more chaotic than that. Suddenly, %wildman% growls and pushes the crowns forward and takes the stick away from you. Looks like the trade is done.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]You crouch down and look at the mess of crowns.%SPEECH_ON%Those are real shiny, huh?%SPEECH_OFF%The wildling grunts and tries to shoo you away. Resisting, you pick up a crown. %wildman%\'s hands drop and head jerks up, glaring at you. Slowly, you put the coin down and then produce a stick with a string wrapped around its top. %wildman% stare slackens, the sturdy stick a slick treat to the unkempt wildling. You motion that you\'ll give it in exchange for the crowns. %wildman% takes the stick. You take the crowns.\n\n But when the wildling plays with the string, it falls off and blows away in the wind. %wildman% cries out, then stares murderously at you, yourself standing there with both arms barreled to try and hold all the crowns. The wildling screams. You drop the crowns and run as fast as you can. There is all manner of chaos going on behind you - tools and weapons being broke, mercenaries running for their lives, and the absolute bedlam of a bunch of confused people beset by a wildling - but you dare not look.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
		}
	}
})
