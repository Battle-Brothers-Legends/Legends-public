::mods_hookExactClass("events/events/dogfighting_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options = [{
					Text = "Alright, but I\'m going with you.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(-1);
						return "B";
					}
				},
				{
					Text = "That\'s not going to happen.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(1);
						return 0;
					}
				}]
			}
			if (s.ID == "B") {
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
			}
			if (s.ID == "J") {
				s.Text = "[img]gfx/ui/events/event_20.png[/img]You throw your betting ticket into the dirt.%SPEECH_ON%Fark it.%SPEECH_OFF%With a quick leap you jump the fence and run into the arena. %doghandler% is right behind you. The two dogs are still at it, but a swift kick gets them separated. The houndmaster quickly grabs %wardog% and lifts him out of danger. The crowd boos and bottles and glasses start flying in. A man blows a whistle that silences them all. He steps into the arena.%SPEECH_ON%These people paid to see blood. If you are not going to give it to them, then you best find another way to pay. How about two hundred crowns? That or you just go ahead and put that dog back down.%SPEECH_OFF%The crowd is cracking their knuckles and drawing out knives, chains, and other crude weaponry.";
			}
		}
	}
})
