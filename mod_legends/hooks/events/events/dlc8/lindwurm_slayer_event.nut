::mods_hookExactClass("events/events/dlc8/lindwurm_slayer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			// %dragonslayer% refers to this.m.Dude. For %dragonslayer%-related pronouns, use %they_dude%. Thank Vanilla code for this confusion
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{You\'re enjoying a drink at one of %townname%\'s cozy taverns. Naturally, this comfort doesn\'t last long as a %person_dude% struts into the place with %their_dude% armor clinking and clanking. You make the error of glancing at %them_dude% and catching %their_dude% eye. %They_dude% immediately heads over. Sighing, you put your opposite hand onto your sword and await what this could possibly be. The %person_dude% stomps to the end of your table and straightens up.%SPEECH_ON%Let me introduce myself, in case rumor and myth have not done it already. I am %dragonslayer%. My chosen life in this world is to hunt and slay dragons.%SPEECH_OFF%You take a drink and set it down, telling the %person_dude% that dragons don\'t exist. %They_dude% grins.%SPEECH_ON%That is because my father slew them all. In truth, I am a killer of lindwurms, and I hear you are the captain of the %companyname%, an outfit of some renown, almost as much as renown as yours truly. What would you say to combining our skills and talents, hm? I\'d be willing to join you for %price% crowns.%SPEECH_OFF%}";
				s.start <- function ( _event )
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					this.Characters.push(_event.m.Dude.getImagePath());
				}

			}
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{You reach into your pockets and put the purse on the table. The %person_dude% takes it up, picking through the change. %They_dude% nods and cinches the pursestrings.%SPEECH_ON%Very well. You have my services, captain of the %companyname%, and by my father\'s good name you shall not regret it.%SPEECH_OFF%}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{The %person_dude% will either prove %themselves_dude% to be worthy of %their_dude% stated accomplishments, or %they_dude%\'ll end up dead meat. If %they_dude%\'s willing to join without any upfront cost to you, what does it hurt to see how %they_dude% fares? You hold your hand out and the %person_dude% shakes it. %Their_dude% armor clinks and clanks as %their_dude% arm bounces up and down.%SPEECH_ON%Your Oathtakers will not be disappointed, that I can promise you.%SPEECH_OFF%}"
			}
			if (s.ID == "A") {

			}
		}
	}
})
