::mods_hookExactClass("events/events/sellsword_gets_better_deal_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]While counting inventory, %sellsword% joins your side, mindlessly picking at this sword or that shield. You set your quill pen down and ask what\'s up for the hired blade sure as shit isn\'t here to count anything. The sellsword explains that another company wishes to use the mercenary\'s swordhand - and they\'re willing to pay more. You ask how much and the sellsword holds up hands to count.%SPEECH_ON%They\'re talking %newpay% crowns a day.%SPEECH_OFF% %sellsword%\'s earning %pay% crowns a day with you.";
				s.Options[0] = {
					Text = "I see, time to part ways then.",
					function getResult( _event ) {
						_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
						::Legends.addFallen(_event.m.Sellsword, "Got a better paying offer");
						this.World.getPlayerRoster().remove(_event.m.Sellsword);
						return 0;
					}
				}
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] You turn around, crossing your arms and jacking a boot against a crate. Staring out across the land, you tell %sellsword% that the company has been through a lot together and everyone, yourself especially, would hate to say farewell. There is a second family here with the %companyname% and that\'s a rare treat in the mercenary world. In other companies there is no guarantee of what may be found. You know, because you\'ve been there. You\'ve been in the sellsword's very shoes, and you took those shoes and walked. And regretted it.\n\nThe sellsword looks at the ground, thinking your words over. Finally the hired blade nods and agrees to stay. You reaffirm that it is definately the right choice. The mercenary turns and taps a quiver of arrows while walking away.%SPEECH_ON%Might want to refill that.%SPEECH_OFF%";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_16.png[/img] You turn around, crossing your arms and jacking a boot against a crate. Staring out across the land, you tell %sellsword% that the company has been through a lot together and everyone, yourself especially, would hate to say farewell. There is a second family here with the  %companyname% and that\'s a rare treat in the mercenary world. In other companies there is no guarantee of what may be found. You know, because you\'ve been there. You\'ve been in the sellsword's very shoes, and you took those shoes and walked. And regretted it.\n\n The sellsword looks at the ground, thinking your words over. Finally the hired blade's head shakes slowly, with pursed lips and a look of \'sorry\'. You argue that it is the wrong choice, but %sellsword%\'s having none of it. The mercenary turns and taps a quiver of arrows while walking away.%SPEECH_ON%Might want to refill that.%SPEECH_OFF%The arrows are a little low, but all you can think about is figuring out how to replace such a good swordhand";
				s.start <- function (_event) {
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Sellsword.getName() + " leaves the " + this.World.Assets.getName()
					});
					_event.m.Sellsword.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_event.m.Sellsword, "Got a better paying offer");
					this.World.getPlayerRoster().remove(_event.m.Sellsword);
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img] You sigh. %sellsword% nods and starts to leave, but you stop the mercenary. You\'ll pay the amount to stay the move. The %companyname% simply cannot afford to lose a blade like that.";
				s.Options[0].Text = "A good sword doesn\'t come cheap.";
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;
		onUpdateScore()
	}
})
