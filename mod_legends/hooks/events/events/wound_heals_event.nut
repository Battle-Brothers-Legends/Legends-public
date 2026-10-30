::mods_hookExactClass("events/events/wound_heals_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function(_screen) {
			_screen.start <- function ( _event ) {
				local bg = _event.m.Injured.getBackground().getID();

				if (bg == ::Legends.Backgrounds.getID(::Legends.Background.Monk) || bg == ::Legends.Backgrounds.getID(::Legends.Background.Flagellant) || bg == ::Legends.Backgrounds.getID(::Legends.Background.PacifiedFlagellant) || bg == ::Legends.Backgrounds.getID(::Legends.Background.MonkTurnedFlagellant) || bg == ::Legends.Backgrounds.getID(::Legends.Background.Cultist))
					this.Text = "[img]gfx/ui/events/event_34.png[/img]{You go to check on %hurtbrother% - %they_hurtbrother%\'d suffered a terrible wound not long ago and sometimes it can lift a %person_hurtbrother%\'s spirits just to let %them_hurtbrother% know others care. Thinking you\'ll find the %person_hurtbrother% nursing %their_hurtbrother% injuries, you instead are surprised to see that %they_hurtbrother% is in good health. The wounds have apparently healed in such speedy fashion that others might call it a miracle. | %hurtbrother% was injured in battle and you figure it\'d be best to go see how %they_hurtbrother% is doing. Surprisingly, %they_hurtbrother%\'s doing quite well. %Their_hurtbrother% wounds have healed in such quick fashion you almost want to believe %they_hurtbrother% consulted some dark arts while no one was looking. There are no signs of black magics around, just one sturdy and hard to kill %person_hurtbrother% of flesh and blood. | %hurtbrother% enters your tent and flashes %their_hurtbrother% wound - or what\'s left of it. The garish thing has seemingly healed entirely. The mercenary looks at you with a giddy smile.%SPEECH_ON%They\'ll have to try harder to take me out of this world, captain.%SPEECH_OFF% | %hurtbrother% comes into your tent and shows off an old wound. %They_hurtbrother% speaks excitedly.%SPEECH_ON%Is that a miracle or what?%SPEECH_OFF%The injury has healed almost completely. You tell the %person_hurtbrother% that %they_hurtbrother%\'s made of hardier things and the gods had nothing to do with it. %They_hurtbrother% shakes his head.%SPEECH_ON%You need to have more faith.%SPEECH_OFF% | You go looking for %hurtbrother% - the mercenary had taken quite the injury last you saw. The %person_hurtbrother%, however, is in high spirits. %They_hurtbrother% turns to you, taking a break from sharpening some steel.%SPEECH_ON%Need something, sir?%SPEECH_OFF%You inquire about %their_hurtbrother% injury. %They_hurtbrother% shrugs.%SPEECH_ON%I don\'t die easy. {I ate a lot of them pointy orange things when I was young. | I ate a lot of lettuce growing up. One might say I\'m hard to... kale.}%SPEECH_OFF%}";
				else
					this.Text = "[img]gfx/ui/events/event_34.png[/img]{You go to check on %hurtbrother% - %they_hurtbrother%\'d suffered a terrible wound not long ago and sometimes it can lift a %person_hurtbrother%\'s spirits just to let %them_hurtbrother% know others care. Thinking you\'ll find the %person_hurtbrother% nursing %their_hurtbrother% injuries, you instead are surprised to see that %they_hurtbrother% is in good health. The wounds have apparently healed in such speedy fashion that others might call it a miracle. | %hurtbrother% was injured in battle and you figure it\'d be best to go see how %they_hurtbrother% is doing. Surprisingly, %they_hurtbrother%\'s doing quite well. %Their_hurtbrother% wounds have healed in such quick fashion you almost want to believe %they_hurtbrother% consulted some dark arts while no one was looking. There are no signs of black magics around, just one sturdy and hard to kill %person_hurtbrother% of flesh and blood. | %hurtbrother% enters your tent and flashes %their_hurtbrother% wound - or what\'s left of it. The garish thing has seemingly healed entirely. The mercenary looks at you with a giddy smile.%SPEECH_ON%They\'ll have to try harder to take me out of this world, captain.%SPEECH_OFF% | %hurtbrother% comes into your tent and shows off an old wound. %They_hurtbrother% speaks excitedly.%SPEECH_ON%Is that a miracle or what?%SPEECH_OFF%The injury has healed almost completely. You tell the %person_hurtbrother% that %they_hurtbrother%\'s made of hardier things and the gods had nothing to do with it. %They_hurtbrother% shakes his head.%SPEECH_ON%%They_hurtbrother% nods.%SPEECH_ON%Yeah, I know. But it\'d be nice if they were looking out for me, too. Just in case...%SPEECH_OFF% | You go looking for %hurtbrother% - the mercenary had taken quite the injury last you saw. The %person_hurtbrother%, however, is in high spirits. %They_hurtbrother% turns to you, taking a break from sharpening some steel.%SPEECH_ON%Need something, sir?%SPEECH_OFF%You inquire about %their_hurtbrother% injury. %They_hurtbrother% shrugs.%SPEECH_ON%I don\'t die easy. {I ate a lot of them pointy orange things when I was young. | I ate a lot of lettuce growing up. One might say I\'m hard to... kale.}%SPEECH_OFF%}";

				this.Characters.push(_event.m.Injured.getImagePath());
				local injuries = _event.m.Injured.getSkills().query(::Const.SkillType.TemporaryInjury);
				local injury = injuries[::Math.rand(0, injuries.len() - 1)];
				this.List = [{
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Injured.getName() + " no longer suffers from " + injury.getNameOnly()
				}];
				injury.removeSelf();
				_event.m.Injured.updateInjuryVisuals();
				_event.m.Injured.getSkills().update();
			}
		});
	}

	o.onUpdateScore = function () {
		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (!::Legends.Backgrounds.hasAny(bro, ::Legends.Background.Slave, ::Legends.Background.LegendDonkey) && bro.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury))
				candidates.push(bro);

		if (candidates.len() == 0)
			return;

		this.m.Injured = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}
})
