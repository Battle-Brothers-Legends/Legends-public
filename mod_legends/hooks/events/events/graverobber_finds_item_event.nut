::mods_hookExactClass("events/events/graverobber_finds_item_event", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]The weather is nice. A fine evening, if any, for the moon to be where it is: an orange rind of it slipping in and out of the clouds - clouds that pass by on the seemingly innocuous gesture that a light breeze can have. So bright is this rim of a moon you wonder if any flowers might bloom, mistaking the evening light for its brighter cousin. You wonder if the millmoths and flies and armor-backed beetles see the moon and dance toward it as they would any candle or torch. Do they have that quiet desperation? That inescapable cruelty of realizing that, when your stock is placed against the greater whole, you have and are nothing... and the hatred that realization can bring, and the jealousy...\n\nSuddenly, %graverobber% the graverobber appears by your side, %their_graverobber% smell skewering your thoughts with miasmic proficiency. %They_graverobber%\'s hardly a %person_graverobber% at all, but a golem, mudslaked and grass-peppered with two white eyes peering out. Sighing, you ask what %they_graverobber% wants. %They_graverobber% thumbs over one shoulder, the other occupied by a shovel.%SPEECH_ON%Went digging through a grave or three. Found somethin\' and I don\'t mean just what them graves are for. Wanna come take a look?%SPEECH_OFF%Of course you do...";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]%graverobber% brings you to a big hole in the ground. The top half of a skeleton is at the bottom, its arms loose over the earth as though it had bedded there for a night\'s rest. Empty eye sockets look up at you. The graverobber crouches and grabs something. %They_graverobber% wipes the mud and worms off it and hands it over.%SPEECH_ON%I think we can use that.%SPEECH_OFF%You nod, but tell the man to quickly fill the grave before anyone sees what %they_graverobber%\'s done.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]While looking down at the goods, %historian% the rather astute scholar and historian sidles up next to you. %They_historian%\'s rubbing %their_historian% chin and a faint hum ruminates deeply within %them_historian%.%SPEECH_ON%Yes, yes...%SPEECH_OFF%You turn to %them_historian% to ask what %they_historian%\'s going on about. %They_historian% snaps %their_historian% fingers and points down at what the graverobber had found. %They_historian% explains that this isn\'t just any chest plate or weapon, but indeed the gear of a famous fighter, nobleman, and womanizer, %noblename%.";
			}
		}
	}

	o.onUpdateScore = function ()
	{
		if (this.World.getTime().IsDaytime)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_graverobber = [];
		local candidates_historian = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.graverobber")
				candidates_graverobber.push(bro);
			else if (bro.getBackground().getID() == "background.historian" || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
				candidates_historian.push(bro);
		}

		if (candidates_graverobber.len() == 0)
			return;

		this.m.Graverobber = candidates_graverobber[this.Math.rand(0, candidates_graverobber.len() - 1)];

		if (candidates_historian.len() != 0)
			this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];

		this.m.Score = 5;
	}
})
