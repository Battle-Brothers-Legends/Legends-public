::mods_hookExactClass("events/events/dlc2/teamplayer_is_bro_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_65.png[/img]{%teamplayer%, always the sort to take one for the company, seems to have singlehandedly helped the resolve of each mercenary. As one sellsword explains it.%SPEECH_ON%I dunno how to explain it.%SPEECH_OFF%As another more articulate mercenary says.%SPEECH_ON%It\'s like %they%\'s more than just a sword for hire, you know? %They%\'s someone we can depend on. Like a %sibling%. But not a whole %sibling%, obviously. More like a half%sibling%. A %sib%, if you will.%SPEECH_OFF%}";
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars ) {
		_vars.push([
			"teamplayer",
			this.m.Teamplayer.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Teamplayer.getGender())
	}
});
