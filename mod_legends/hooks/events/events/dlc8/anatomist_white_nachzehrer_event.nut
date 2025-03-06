::mods_hookExactClass("events/events/anatomist_white_nachzehrer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_184.png[/img]{%anatomist% hasn\'t been writing in %their_anatomist% journals so much lately. When %they_anatomist% does, the pen only seems to tap the pages now and again without scribbling anything of import. You inquire as to what has %them_anatomist% so bothered. Somber in tone, %they_anatomist% says that %their_anatomist% primary hope in coming out to these lands was to find the White Nachzehrer, a monster that\'s larger than any of its kind. You tell %them_anatomist% that you\'ve slain a few nachs that were quite rotund, but the anatomist shakes %their_anatomist% head.%SPEECH_ON%Per the literature, this nachzehrer cannot be felled by any man for it has grown to such proportions that its flesh has turned white, and it is covered in great ridges of calloused skin that no steel can penetrate. It was spotted roaming these lands and I\'d hoped to find it, but it seems that, perhaps, I have been led astray. Maybe the anatomists who told me this tale have put me on a great snipe hunt. I worry, scapegrace, that I have been made a fool of.%SPEECH_OFF%You tell %them_anatomist% that this creature sounds like the \'king\' of nachzehrers, and if that\'s the case then perhaps it no longer roams, but instead uses a small army of lesser nachzehrers to do its bidding for it. The anatomist smiles.%SPEECH_ON%Truly, this may be the case! Of course it took the scrying eye of the laity, so used to staring up at our purpled suzerains, to bring this to my clouded attention!%SPEECH_OFF%Agreeing with yourself further, you note that perhaps the \'White Nachzehrer\' is so pale cause it doesn\'t get much sun. The anatomist laughs.%SPEECH_ON%Please, scapegrace, the first observation was sufficient input from your side.%SPEECH_OFF%}";
			}
		}
	}

	local onPrepareVariables = onPrepareVariables;
	o.onPrepareVariables <- function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "anatomist");
	}
});
