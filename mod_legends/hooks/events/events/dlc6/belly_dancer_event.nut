::mods_hookExactClass("events/events/dlc6/belly_dancer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{A belly dancer magnetizes %townname%\'s center plaza. Rhythmic movements on their own can coerce a beggar to donating a crown, but with the stage of the whole plaza it is enough to draw crowds and with it heaps of gold. Masked by green silk, nearly see through, and clothed in thin silks with the whole midriff exposed, the dancer is no doubt an expert in her field. She whirls, hips hypnotic, elbows bowed, hands clapping little cymbals, her feet tiptoeing as she spins a spot so tight there very well may be an invisible god above holding her in place as she razzles and dazzles.\n\n Someone throws an apple through the air and the dancer spins around and shoots a tiny dagger through it, plugging it dead center and dropping the fruit to the ground. Another apple soars in and this time a large saber is produced and slashes the stem off and she catches the rest and takes a bite. The crowd claps gently to this.}";
		}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{You take out a crown and flip it to the dancer. Her eyes catch its glint, but she doesn\'t break the dance. She drops her weapons and sashays over, cymbals clattering, hips gyrating, her knees hardly bending, her feet almost mystically carrying her across the ground. She claps the cymbals in your face, then swings around, briefly bumping you with her hips, and starts to dance back to the middle. She picks up your coin with a toe and flips it up and it lands in a clay pot. The crowd cheers.}",
				s.Options[0].Text = "Maybe we can make use of this woman?";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{After the belly dancer takes your crown you wait around for the show to end. You approach as she picks up daggers and coins. She looks at you with a wry smile.%SPEECH_ON%Ah, an admirer. Sorry, only one show tonight, darling.%SPEECH_OFF%You shake your head and ask if she knows anything about fighting. She nods.%SPEECH_ON%The Gilded One\'s gleam is upon us all, but not at all hours or days. Sometimes, we must find our own way through the dark. I take it by your dress that you are a Crownling, putting that blade of yours where it does and sometimes does not belong.%SPEECH_OFF%You nod and ask her if she\'d be interested in joining. She drops, bowlegged, and sinks to the ground like a collapsing truss. She counts her crowns.%SPEECH_ON%I\'m not sure if you have a good eye for the wandering nature of ones such as myself. Perhaps there is a certain... recognition, for those of us willing to kill for what we want. That said, you\'ll have to try harder to get me to go around killing for coin...%SPEECH_OFF%}";
				s.start <- function( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"belly_dancer_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "You found %name% in " + _event.m.Town.getName() + ", masked by green silk and drawing crowds with rhythmic movements and impressively precise fruit slicing. The latter skill is a boon to any mercenary company, and so you didn\'t hesitate to recruit them	.";
					_event.m.Dude.getBackground().buildDescription(true);
					::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Dexterous);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{You assuage her ego by saying she\'s one of the best with the blade you\'ve seen. The dancer turns her hands to the dust, her fingers sliding beneath each coin and flipping it into her clay pot. Her left hand reaches across the ground, but as this catches your eye, her right hand snatches a blade that had been entirely buried beneath the sands. She holds it toward your crotch.%SPEECH_ON%I\'m deadly with the blade, as I\'m sure you are with that stinger there. Now, I know you are merely petting things which shall make me purr, preying upon my pride as the hunter does the lions, and I will say this: it has worked. I will fight for you, captain of the Crownlings, and I will fight well.%SPEECH_OFF%Nodding, you ask that she lower the blade. She spins it in her hand and sheathes it in one swift motion. She gets to her feet and dresses in a more sturdy outfit.%SPEECH_ON%This life I will leave behind in total, and to the Crownling\'s life I will be devoted in whole.%SPEECH_OFF%You shake the woman\'s hand. Just at that moment, a leering passerby struts over and attempts to clutch her by her hips. Without as much as a glance nor warning, she throws a knife out of nowhere, landing point first in a pole right next to the passerby\'s hips. He stumbles backwards, yelling in a mix a fear and surprise%SPEECH_ON%Hey! I thought you were a lady of the dance! I just wanted to dance!%SPEECH_OFF%Finally turning to face him, her expression darkens into a foreboding smile%SPEECH_ON% How uncouth! You\'d best be careful what you ask for. I now dance the dance of death%SPEECH_OFF%The dancer looks at you and laughs.%SPEECH_ON%We\'ve all dangers to confront in our respective vocations, Crownling, and I look forward to seeing yours.%SPEECH_OFF%}";
		}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{You tell the dancer that she is one of the best you\'ve seen with a blade. She laughs.%SPEECH_ON%A truly well intentioned attempt on your part, Crownling, to drag me to your ways of life. But you know well that there is nothing you could say or do that would take me away from this life. Yes, the blade suits me well, but so does flittering about for the crowd, earning praise without spilling blood to do it. You go play gladiator on the sands and earn your coin, Crownling, and I will be here earning mine.%SPEECH_OFF%}";
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{You offer five hundred crowns to the dancer. She keeps picking up the coins from her performance- one at a time - and putting them in her clay pot. It is almost a silent affair, coins clapping loudly as they fall into a nearly empty barrel of clay. She looks up, looks down. She puts in one more crown then gets to her feet. She strips off her clothes and holds out her hand.%SPEECH_ON%The Gilded One must be gleaming upon us both, for you to have earned such keep, and no doubt He has guided your purse here to bring it to me.%SPEECH_OFF%You nod and shake her hand. The dancer asks that she take a look at your inventory.%SPEECH_ON%A body like mine, anything will fit, inside or out, I\'ll make it work.%SPEECH_OFF%}";
			}
		}
	}
o.onUpdateScore = function(){
	this.m.Score = 0;//disable
}
})
