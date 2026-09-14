::mods_hookExactClass("events/events/dlc2/glutton_eats_apple_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_18.png[/img]{You come to a commotion between %glutton% the glutton and a bucket. %They_glutton%\'s heaving into it so hard %their_glutton% back lurches like a cat and %their_glutton% hurls sound like an undead cow giving birth. When he lifts %their_glutton% head %their_glutton% face looks like a gourd, cheeks ballooned, %their_glutton% mouth still all agargle. %otherbrother% comes over.%SPEECH_ON%%They_glutton% ate the witch\'s apple.%SPEECH_OFF%Raising an eyebrow, you ask the glutton why he would do such a thing. Vomit strings wriggle from %their_glutton% wrist as he wipes %their_glutton% eyes.%SPEECH_ON%{Cause I\'m always hungr-hurgh, uh, hungregghhh! | I don\'t rightfully know sir can\'t I just be in pain without having to validate my actiiiherrrghh! | Would I have to explain myself if I wasn\'t losing my gouerrrghhhh! | Cause you told me to eat healthy and it was an apperrrghghh!}%SPEECH_OFF%%They_glutton% pitches %their_glutton% head back into the bucket like a man who dropped a million crowns down a well. You tell the mercenaries to keep an eye on %them_glutton% until it\'s all out of %their_glutton% system, that is if it ever will be.}";
			_screen.Options[0].Text = "Let this be a lesson for you.";
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				::Legends.Traits.remove(_event.m.Glutton, ::Legends.Trait.Gluttonous);
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_07.png",
					text = _event.m.Glutton.getName() + " is no longer a gluttonous"
				});
			}
		});
	}

	o.onUpdateScore = function()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_glutton = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (::Legends.Traits.has(bro, ::Legends.Trait.Player))
			{
				continue;
			}

			if (::Legends.Traits.has(bro, ::Legends.Trait.Gluttonous) && !bro.isStabled())
			{
				candidates_glutton.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_glutton.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasItem = false;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.poisoned_apple")
			{
				hasItem = true;
				break;
			}
		}

		if (!hasItem)
		{
			return;
		}

		this.m.Glutton = candidates_glutton[this.Math.rand(0, candidates_glutton.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_glutton.len() * 5;
	}
})
