::mods_hookExactClass("events/events/dlc2/location/golden_goose_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_125.png[/img]{You step into the bowels of the ship. It\'s completely vacant save for a stump with an axehead chopped into it. %observer% looks at it.%SPEECH_ON%There\'s an axehead.%SPEECH_OFF%Nodding, you say there it is indeed. But the metal of it carries veins of a sort of golden hue. Getting closer to the stump, you can see embers flittering upward out of the wedge. %observer% taps your shoulder and you find %them_observer% pointing into the dark of the ship.%SPEECH_ON%Skeleton. Dead one.%SPEECH_OFF%Just faintly can you see the pale bones. As you draw near, the clothing becomes apparent, and readily obvious as royal attire. There is a cracked ale horn in one hand and a molded loaf of bread in the other. His jacket is blown open and shredded by splinters. Upon closer inspection, some of the wood is embedded in his brainpan.}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_125.png[/img]{Seeing as how the skeleton and his beer and bread ain\'t going anywhere, you leave it be. The axehead however draws your eye again. %observer% walks over to the stump and the glowing wedge. %They_observer% tries to take it out. Finding no luck there, %they_observer% steps back and kicks it further in. The trump cracks in twain and the sellsword suddenly flies upside down and the axehead shoots through the roof of the boat and you can hear it clunk and clatter down its sides outside. Debris and smoke drift lazily about. The sellsword gets up and pats %themselves_observer% off.%SPEECH_ON%What in all the hells was that?%SPEECH_OFF%You shush %them_observer% and point. A little golden goose squats where the stump\'s base used to be. The sheen of its metal glows and swirls. You\'ve heard stories of a golden goose, but never thought they were anything beyond that!}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_125.png[/img]{%observer% stumbles forward.%SPEECH_ON%Sir, what are you doing?%SPEECH_OFF%You wave %them_observer% off and pick the golden goose up. Holding it in both hands, it feels oddly warm. And it isn\'t exploding or melting your face. You can feel its metal rippling ever so slightly against your fingers. It might even be growing? With the treasure safely huddled beneath your elbow, you wonder why the skeleton didn\'t fare better. %observer% walks up and touches the golden goose on the head, but quickly recoils. You ask if it burned %them_observer%. The sellsword purses %their_observer% lips.%SPEECH_ON%Really, sir? Was it not obvious?%SPEECH_OFF%%They_observer% sticks %their_observer% finger in %their_observer% mouth. You tell %them_observer% to not be so snappy with %their_observer% commander or you\'ll throw the goose at %them_observer% and see if it makes short work of %them_observer% as it did the skeleton. The %person_observer% shrugs.%SPEECH_ON%Oh look at the man chosen by a shiny bauble, put a blade beneath a wing so it can knight ye, or hells why not put it on yer head and call yerself king already?%SPEECH_OFF%You look down at the goose. A drop of red blood runs down its length, turns gold, and drops to the ground with a tiny plink. You pick it up and bite it. The gold smooshes satisfyingly in your teeth and you then throw it to %observer%. It does not burn %them_observer% this time, and you realize you may have found the genuine Golden Goose from the tales!}";
			}
		}
	}

	o.onPrepare = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble) && !bro.getSkills().hasTrait(::Legends.Trait.Bright) && !bro.getSkills().hasTrait(::Legends.Trait.ShortSighted) && !bro.getSkills().hasTrait(::Legends.Trait.NightBlind))
				candidates.push(bro);
		}

		if (candidates.len() != 0)
			this.m.Observer = candidates[this.Math.rand(0, candidates.len() - 1)];
		else
			this.m.Observer = brothers[this.Math.rand(0, brothers.len() - 1)];
	}
});
