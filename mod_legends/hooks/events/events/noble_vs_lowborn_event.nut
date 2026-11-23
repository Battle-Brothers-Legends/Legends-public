::mods_hookExactClass("events/events/noble_vs_lowborn_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		// %nobleman% and %nobleman_short% refer to this.m.Noble. For %nobleman%-related pronouns, use %they_noble%. Thank Vanilla code for this confusion
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img] You find the %noble_noble% %nobleman_short% and the rather ragged-looking %lowborn% quarreling over the last piece of food on a spit. Apparently the lowborn got %their_lowborn% fork to it first, but the %noble_noble% claimed that %their_noble% high stature granted %them_noble% the right to the meat.";
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_06.png[/img] As the they look to you for guidance, you fold your arms and shrug. They slowly turn back to one another. The other people in the camp stand up and step back, giving room to what is coming. The lowborn draws %their_lowborn% dagger first. It is a simple thing with a wooden handle and jagged, unnaturally serrated edges. The %noble_noble% pulls %their_noble% blade in return, brandishing a metal that curves with the care of a blacksmith\'s mastery. Two golden snakes curl up the handle to bite the pommel. Its wielder grins, saying the riff-raff should learn their place. The lowborn grins like a %person_lowborn% who has had no practice doing it.\n\nSurprisingly, both then chuck the daggers into the stumps upon which they sat and close rank with fists raised, the most equal of fighting grounds. In the ensuing battle the spit is immediately knocked aside and flames fan upward, raining wild embers and the felled food is now flavored with ash and soot.\n\nSeeing their meal ruined, the rest of the company finally puts an end to the combat, pulling the two apart. They threaten and spit at one another, but after a few minutes everything settles down.";
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img]%nobleman% looks aghast. %They_noble% slowly lifts %their_noble% fork from the spit and %lowborn% immediately shovels the last bit of meat into %their_lowborn% mouth. The %noble_noble% gets up and heads your way. %They_noble% straightens before you, bumping %their_noble% chest into yours as you lock eyes. A few of the people put their hands on their pommels.%SPEECH_ON%{Siding with the lowborn, huh? I fancied you would, being lowborn yourself. Don\'t ever expect to become one of us. You\'re a sellsword for life. Remember that. | You expect to get a piece of land when all this is said and done, yeah? I hope you do, because then I\'ll come and knock and show you how nobles really treat one another.}%SPEECH_OFF%";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img]%nobleman% grins as he knocks %lowborn%\'s fork out of the way. The %noble_noble% takes the food for himself as the lowborn gets up and storms toward you. As %they_lowborn% nears, some sellswords look ready to draw swords, but you hold a hand out, calming them.%SPEECH_ON%I thought you were one of us, but I guess not. I suppose you think someday you\'ll be one of them, huh? Keep dreaming. As that man would say to me, \'Know your place\'.%SPEECH_OFF%";
		});
	}
});
