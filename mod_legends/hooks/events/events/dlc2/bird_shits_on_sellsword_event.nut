::mods_hookExactClass("events/events/dlc2/bird_shits_on_sellsword_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "%terrainImage%{While traveling the land, %birdbro% gets struck by birdshite. It hits their swordhand and splashes crosswise all over their armor.%SPEECH_ON%Aww, awwww!%SPEECH_OFF%Their arms go wide like chicken wings as he looks at the damage.%SPEECH_ON%Bloody hell, just my luck!%SPEECH_OFF%}";
			}
			if (s.ID == "Superstitious") {
				s.Text = "%terrainImage%{The ever superstitious %superstitious% analyzes the shit with the appraising eye of a proper jeweler. He purses their lips and nods, as satisfied a summary of bird shit as there ever was. He says.%SPEECH_ON%This is a good thing.%SPEECH_OFF%In the face of very incredulous company the man calmly explains that being shat on by a bird is an omen of good things to come. A few of the sellswords seem convinced by this notion. It is rather spectacular to have a bird choose you, out of all earth below, to land a squat on. You nod and say %birdbro% should open their mouth next time for extra special good fortune.}";
			}
			if (s.ID == "Archer") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]{%archer% looks up, hand shielded over their eyes, tongue out. He sees the bird and nods. He licks a finger, puts it to the air, and nods again. The archer grins as he nocks an arrow.%SPEECH_ON%With crime there is punishment.%SPEECH_OFF%The mercenaries groan and mock the man\'s moralizing, but he calmly raises the bow and lets the arrow loose. It zips and shrinks high into the air and you can hardly see the shot but you do see the bird suddenly crank sideways and start twirling to the earth. The sharpshooter nods and looks over at the company.%SPEECH_ON%You laughing now?%SPEECH_OFF%This only brings more jeers. The archer snidely comments about their importance and this brings about a healthy debate between the men who stand on the frontline and those in the back. You tell the men that if they want to argue which is better they can prove it on the battlefield.}";
			}
			if (s.ID == "Historian") {
				s.Text = "%terrainImage%{You tell %birdbro% that being shit on is a part of life and get the company ready to get back on the road. But a modest %historian% comes up and tells the ill-fated sellsword to hold off on cleaning the shite. The historian takes a good look at the shite and then up at the bird which authored it.%SPEECH_ON%Yes, yes... I know that bird! That magical creature!%SPEECH_OFF%The men look up at the bird as though they were sealeagured sailors finding rarified land. %historian% points at %birdbro%.%SPEECH_ON%You got shat on by a red-and-blue mockingbird! That\'s all I wanted to say, really. I just hadn\'t seen one in awhile. You... you can clean it now.%SPEECH_OFF%The mercenaries stand slackjawed before bursting into laughter. %birdbro% grabs the historian and uses their sleeves to clean the shit off which brings more roars from the men.}";
			}
		}
	}
});
