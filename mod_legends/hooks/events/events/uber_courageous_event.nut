::mods_hookExactClass("events/events/uber_courageous_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_50.png[/img]%juggernaut% carries a brand of courage one part fearless, one part craziness. %They_juggernaut% urgency to throw himself against %they_juggernaut% enemies is inspirational, if no doubt foolish to a mind of reason and rationality. But this is the %companyname%, a band of men who are drawn to the simple life of sword and coin. %juggernaut%\'s indomitable nature in this struggle of kill or be killed has rubbed off on a few of the sellswords.";
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Juggernaut.getGender(), "juggernaut");
	}
});
