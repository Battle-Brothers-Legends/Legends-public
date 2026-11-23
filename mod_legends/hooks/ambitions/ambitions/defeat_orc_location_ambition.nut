::mods_hookExactClass("ambitions/ambitions/defeat_orc_location_ambition", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_81.png[/img]With the %recently_destroyed% still smouldering in your wake, a group of people come out from their hiding place in a nearby copse of trees where they had been watching the battle from afar. An old woman approaches you.%SPEECH_ON%Those green-skinned fiends drove us from our farm outside %nearesttown%, but thanks to you stalwart fellows we will prosper again. This is for you.%SPEECH_OFF%She proffers a bag of apples. Though it isn\'t much of a reward, the sentiment will be repeated again and again as word spreads of the orcs\' destruction. %highestexperience_brother% barks out a laugh and bites into one of the juicy apples.%SPEECH_ON%With orcs, the big ones are too slow, and the young ones too stupid. Strategy overcomes brute force every time. The great green beasts depend on fear to do their work for them. Stand fast and they can be beat like anyone else!%SPEECH_OFF%The peasants marvel at %highestexperience_brother%\'s speech, and prowess, and strength, clapping their hands, showering %them_veteranbrother% with compliments and patting %them_veteranbrother% on the back. While certainly true words, this is hardly the audience that should put %their_veteranbrother% advice to use. You lay your hand on %highestexperience_brother%\'s shoulder, as if to say to drop it a notch, lest any of the peasants think themselves heroes next time they spot a greenskin.";
	}

	o.onPrepareVariables = function (_vars) {
		local brothers = this.World.getPlayerRoster().getAll();
		local fearful = [];
		local lowborn = [];

		if (brothers.len() > 1) {
			for (local i = 0; i < brothers.len(); i = ++i) {
				if (brothers[i].getSkills().hasTrait(::Legends.Trait.Player)) {
					brothers.remove(i);
					break;
				}
			}
		}

		foreach (bro in brothers) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Superstitious)) {
				fearful.push(bro);
			} else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn)) {
				lowborn.push(bro);
			}
		}

		local fear;

		if (fearful.len() != 0) {
			fear = fearful[this.Math.rand(0, fearful.len() - 1)];
		} else if (lowborn.len() != 0) {
			fear = lowborn[this.Math.rand(0, lowborn.len() - 1)];
		} else {
			fear = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		_vars.push(["fearful_brother", fear.getName()]);
		_vars.push(["recently_destroyed", this.World.Statistics.getFlags().get("LastLocationDestroyedName")]);
	}
});
