::mods_hookExactClass("events/events/spartan_should_eat_more_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] %spartan% has always been a bit tight with how much %they_spartan% eats. You\'re not sure if it\'s part of some religious rite, a sense of duty, or %they_spartan%\'s just not a big eater. Regardless, the lack of food has weakened the %person_spartan% and you find %them_spartan% barely able to sit upright on a log. You\'ve got a bowl of meat and corn in hand, wondering if maybe you should offer it to %them_spartan%.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] You decide that the %person_spartan% has probably been through this before and decide to leave %them_spartan% be. A few moments later, you catch him walking and talking just fine. In fact, %they_spartan% gets around pretty well for a %person_spartan% who eats so lightly!";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] The %person_spartan%\'s done this before, %they_spartan% can do it again. You turn around to go eat your meal elsewhere, only to hear the %person_spartan% crumple to the ground. %They_spartan%\'s completely passed out and appears to have hit %their_spartan% head on the way down.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] You order the %person_spartan% to eat. %They_spartan% resists, but you remind %them_spartan% that it is an \'order\', not a request. The sellsword does as told, eating rather gingerly from your bowl. %They_spartan% complains that %they_spartan% does not wish to eat anymore, but you order %them_spartan% to finish the meal. In time, whatever ailed %them_spartan% seems lifted. Energy returns to %their_spartan% eyes and %they_spartan% gets up with a good spring in %their_spartan% step. Unfortunately, %they_spartan% does not care for being told to break %their_spartan% personal codes.";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] Ordering the %person_spartan% to eat, the %person_spartan% does as told. At first, %they_spartan% seems rather reluctant, but after a few bites %they_spartan% dives into the bowl, engorging %themselves_spartan% in juices and flecks of corn dot %their_spartan% cheeks. %They_spartan% is almost mad with delight. You\'ve reminded %them_spartan% of just how good food can be. Personally, you thought the meat was a little overcooked.";
			}
		}
	}

	local onPrepareVariables = onPrepareVariables;
	o.onPrepareVariables <- function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "spartan");
	}
});
