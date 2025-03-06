::mods_hookExactClass("events/events/kids_and_dead_merchant_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]Despite the miniature military force arrayed before you, the goods are ordered to be taken. The little tyke in charge of this operation screams a warcry more dying cat than diving hawk.%SPEECH_ON%Take them down! Throw! Throw! Throooowww!%SPEECH_OFF%On his command, the mob of children start hurling stones from the treeline. The sellswords band together, holding shields up in a formation akin to a tortoise, and slowly move forward. It\'s a strange effort, like a shell-game artist sliding his cup over the ball, but the company manages to grab the merchant\'s goods and slide away out of the field, all the while being pelted from every which way. The little leader kid shakes his fist at you. You give him the finger and start back onto the path where you take a good look at the merchant\'s goods. %randombrother% stares at the rewards while rubbing a welt on %their_randombrother% forehead.%SPEECH_ON%Goddam, man. I\'ve seen armies not nearly so fierce. I weep for the future men who have to cross swords with those lads and lasses.%SPEECH_OFF%"
				s.List.push({
					id = 10,;
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
			}
		}
	}

	local onPrepareVariables = onPrepareVariables;
	o.onPrepareVariables <- function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "randombrother");
	}
});
