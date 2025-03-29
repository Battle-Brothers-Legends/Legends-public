::mods_hookExactClass("events/events/dlc4/barbarian_volunteer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "%terrainImage%{Unlike the south, finding travelers on the northern \'roads\' is often a cause for caution. You never know what monstrous man or beastly barbarian you\'ll come across next. This time it is a large man limping with a dog beside him. You draw your sword halfway out of its sheath and loud enough to gain his ear. The man looks up and his dog rears to the sudden yank of a leash. The northerner can speak a bit of your tongue.%SPEECH_ON%Ahh, fighters. I\'m a fighter myself.%SPEECH_OFF%You ask why he is alone. He explains that his clan had a dispute, and that he was to duel another man to decide who would take control. You ask why he did not duel this man, you ask if he is afraid. The traveler shakes his head.%SPEECH_ON%No. The clansman was my brother. And I\'d no desire to kill kin. They gave me this bitch here as both insult and reward and threw me from the tribe. I\'ve no land or people to go to, but if you\'d have me, I\'d surely fight for you just as well as anyone else.%SPEECH_OFF%}";
				s.start <- function (_event)
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"barbarian_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "%name% joined you after being exiled from %their% tribe in the north for refusing to kill %their% brother. They\'ll fight for you as well as for anyone.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.getItems().equip(this.new("scripts/items/accessory/legend_warhound_item"));
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
})
