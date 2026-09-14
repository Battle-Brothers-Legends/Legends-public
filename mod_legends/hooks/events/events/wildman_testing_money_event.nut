::mods_hookExactClass("events/events/wildman_testing_money_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]You find %wildman% the wildling stacking %their_wildman% crowns into towers. %They_wildman% leans back from %their_wildman% moneyed manifestations with a wide grin, but then suddenly launches forward, knocking the towers over like a child would their blocks. %They_wildman% laughs maniacally as the coins scatter. The %person_wildman% playing with %their_wildman% money is a curious sight. Perhaps the %person_wildman% has no real conception of what crowns are good for? If so, maybe... maybe you could take them back?";
			_screen.Options[0].Text = "Let\'s see if %wildman% will trade it all away for something else.";
			_screen.Options[1].Text = "Better to leave the wildling crowns alone.";
		});
		::Legends.Screens.hook(this, "B", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]You crouch down.%SPEECH_ON%Hey there %wildman%. Mind if I take one of these?%SPEECH_OFF%Carefully, you pick up a coin and measure the wildling\'s reaction. %They_wildman% shrugs and grunts as if to say \'it\'s yours\'. You take another crown. And then another. The %person_wildman% glares at you, but you slowly produce a stick with a frilly bow tied to the top. Its whirly nature captures the %person_wildman%\'s eye. When %they_wildman% reaches out for it, you draw it back and shake your head. You then point at the crowns, and then at the stick.%SPEECH_ON%One for the other, yes?%SPEECH_OFF%The wildling looks at %their_wildman% crowns, mulling them over like an accountant, but you know %their_wildman% thoughts are far more chaotic than that. Suddenly, %they_wildman% growls and pushes %their_wildman% crowns forward and takes the stick away from you. Looks like the trade is done.";
			local start = _screen.start;
			_screen.start <- function ( _event ) {
				this.List.push(::Legends.EventList.changeMoralReputation(-1));
				start(_event);
			}
		});
		::Legends.Screens.hook(this, "C", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_06.png[/img]You crouch down and look at the mess of crowns.%SPEECH_ON%Those are real shiny, huh?%SPEECH_OFF%The %person_wildman% grunts and tries to shoo you away. Resisting, you pick up a crown. %Their_wildman% hands drop and %they_wildman% jerks %their_wildman% head up, glaring at you. Slowly, you put the coin down and then produce a stick with a string wrapped around its top. %Their_wildman% stare slackens, the sturdy stick a slick treat to the unkempt wildling. You motion that you\'ll give it to %them_wildman% in exchange for the crowns. %They_wildman% takes the stick. You take the crowns.\n\n But when the wildling plays with the string, it falls off and blows away in the wind. %They_wildman% cries out, then stares murderously at you, yourself standing there with both arms barreled to try and hold all the crowns. The wildling screams. You drop the crowns and run as fast as you can. There is all manner of chaos going on behind you - tools and weapons being broke, brothers running for their lives, and the absolute bedlam of a bunch of confused men beset by a wildling - but you dare not look.";
			local start = _screen.start;
			_screen.start <- function ( _event ) {
				this.List.push(::Legends.EventList.changeMoralReputation(-1));
				start(_event);
			}
		});
	}
})
