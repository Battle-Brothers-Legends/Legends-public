::mods_hookExactClass("events/events/wound_heals_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					local bg = _event.m.Injured.getBackground().getID();

					if (bg == "background.monk" || bg == "background.flagellant" || bg == "background.pacified_flagellant" || bg == "background.monk_turned_flagellant" || bg == "background.cultist")
						this.Text = "[img]gfx/ui/events/event_34.png[/img]{You go to check on %hurtbrother% - they\'d suffered a terrible wound not long ago and sometimes it can lift a someone\'s spirits just to know others care. Thinking you\'ll find the mercenary nursing injuries, you instead are surprised to see %hurtbrother% in good health. The wounds have apparently healed in such speedy fashion that others might call it a miracle. | %hurtbrother% was injured in battle and you figure it\'d be best to go see how they are doing. Surprisingly, they\'re doing quite well. Wounds have healed in such quick fashion you almost want to believe some dark arts must have been consulted while no one was looking. There are no signs of black magics around, just one sturdy and hard to kill mercenary of flesh and blood. | %hurtbrother% enters your tent and flashes the wound - or what\'s left of it. The garish thing has seemingly healed entirely. The mercenary looks at you with a giddy smile.%SPEECH_ON%They\'ll have to try harder to take me out of this world, captain.%SPEECH_OFF% | %hurtbrother% comes into your tent and shows off an old wound, speaking excitedly.%SPEECH_ON%Is that a miracle or what?%SPEECH_OFF%The injury has healed almost completely. You say the mercenary is made of hardier things and the gods had nothing to do with it. %hurtbrother%\'s head shakes at you.%SPEECH_ON%You need to have more faith.%SPEECH_OFF% | You go looking for %hurtbrother% - the mercenary had taken quite the injury last you saw. The mercenary, however, is in high spirits. Turning to you, taking a break from sharpening some steel.%SPEECH_ON%Need something, sir?%SPEECH_OFF%You inquire about the injury and are greeted with a shrug.%SPEECH_ON%I don\'t die easy. {I ate a lot of them pointy orange things when I was young. | I ate a lot of lettuce growing up. One might say I\'m hard to... kale.}%SPEECH_OFF%}";
					else
						this.Text = "[img]gfx/ui/events/event_34.png[/img]{You go to check on %hurtbrother% - they\'d suffered a terrible wound not long ago and sometimes it can lift a someone\'s spirits just to know others care. Thinking you\'ll find the mercenary nursing injuries, you instead are surprised to see %hurtbrother% in good health. The wounds have apparently healed in such speedy fashion that others might call it a miracle. | %hurtbrother% was injured in battle and you figure it\'d be best to go see how they are doing. Surprisingly, they\'re doing quite well. Wounds have healed in such quick fashion you almost want to believe some dark arts must have been consulted while no one was looking. There are no signs of black magics around, just one sturdy and hard to kill mercenary of flesh and blood. | %hurtbrother% enters your tent and flashes the wound - or what\'s left of it. The garish thing has seemingly healed entirely. The mercenary looks at you with a giddy smile.%SPEECH_ON%They\'ll have to try harder to take me out of this world, captain.%SPEECH_OFF% | %hurtbrother% comes into your tent and shows off an old wound, speaking excitedly.%SPEECH_ON%Is that a miracle or what?%SPEECH_OFF%The injury has healed almost completely. You say the mercenary is made of hardier things and the gods had nothing to do with it. Nodding, the reply comes.%SPEECH_ON%Yeah, I know. But it\'d be nice if they were looking out for me, too. Just in case...%SPEECH_OFF% | You go looking for %hurtbrother% - the mercenary had taken quite the injury last you saw. The mercenary, however, is in high spirits. Turning to you, taking a break from sharpening some steel.%SPEECH_ON%Need something, sir?%SPEECH_OFF%You inquire about the injury and are greeted with a shrug.%SPEECH_ON%I don\'t die easy. {I ate a lot of them pointy orange things when I was young. | I ate a lot of lettuce growing up. One might say I\'m hard to... kale.}%SPEECH_OFF%}";

					this.Characters.push(_event.m.Injured.getImagePath());
					local injuries = _event.m.Injured.getSkills().query(this.Const.SkillType.TemporaryInjury);
					local injury = injuries[this.Math.rand(0, injuries.len() - 1)];
					this.List = [{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Injured.getName() + " no longer suffers from " + injury.getNameOnly()
					}];
					injury.removeSelf();
					_event.m.Injured.updateInjuryVisuals();
					_event.m.Injured.getSkills().update();
				}
			}
		}
	}

	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() != "background.slave" && bro.getBackground().getID() != "background.legend_donkey" && bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				candidates.push(bro);

		if (candidates.len() == 0)
			return;

		this.m.Injured = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}
})
