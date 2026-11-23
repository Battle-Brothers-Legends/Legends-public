::mods_hookExactClass("events/events/noble_more_pay_lowborn_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img] %noble% suddenly enters your tent. %They're_noble% attired in armor and %their_noble% weapon is at %their_noble% side. It almost seems as if %they_noble% dressed up for this occasion, and %they_noble% does indeed stand upright and proper. You ask what it is %they_noble% wants, and %they_noble% speaks with %their_noble% head held high and %their_noble% eyes looking straight ahead.%SPEECH_ON%It has come to my attention that %lowborn% is paid more than I. While I\'ve no issue with the %person_lowborn% personally, I do want to point out that %they_lowborn% is a %person_lowborn% with no birthright to anything but %their_lowborn% own two feet. You can\'t possibly have a lowborn being paid more than a %person_noble% of the purple. We nobles deserve more.%SPEECH_OFF%";
			_screen.Options[0].Text = "I will see to it you are paid no less than %them_lowborn%."
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img]You don\'t necessarily agree with %them_noble%, but at the same time you can see that denying this request may cause some heretofore unseen problems. With a few dashes of your quill pen across the roster scroll, you assign %noble% a higher salary and tell %them_noble% to expect a heavier purse come next payday. The %person_noble% finally looks at you and bows from the waist.%SPEECH_ON%You\'ve made the good and proper decision.%SPEECH_OFF%%They_noble% turns on %their_noble% heels and marches back out with as much gusto as %they_noble% did coming in.";
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img]You tell the %person_noble% to look at you. %They_noble% slowly shifts %their_noble% eyes to yours. Having %their_noble% attention, you explain how it is around here.%SPEECH_ON%I pay on seniority and veterancy, not who you were before you signed the dotted line. You could be a goatfarmer for all I care, if you can swing a sword you\'ll get paid, and if you can swing it better than the next man then I\'ll be damned, you\'ll be getting paid more than the next man! Anything in that you don\'t understand?%SPEECH_OFF%%noble%\'s jowls quiver as %they_noble% bottles a sudden spurt of rage. %They_noble% speaks through clenched teeth.%SPEECH_ON%No, sir.%SPEECH_OFF%With a flick of a wrist, you tell %them_noble% to get out of your sight. %They_noble% leaves in a hurry, %their_noble% upright stance falling into a seething slouch.";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_64.png[/img]You stand up out of your chair and yell at the %person_noble% to look at you. %They_noble% does as told and so you explain what is going to happen.%SPEECH_ON%%lowborn% made it through this world by dragging %themselves_lowborn% out of the mud. You were born with a silver spoon, but this isn\'t where you were born now is it? So from today consider your pay effectively lowered. You want the right to a higher salary? Earn it.%SPEECH_OFF%The noble\'s stance falters. %They_noble% opens %their_noble% mouth, but you quickly raise your hand.%SPEECH_ON%No more words. Get out of my sight.%SPEECH_OFF%";
		});
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getMoney() < 500) {
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf") {
			return;
		}

		if (this.World.Retinue.hasFollower("follower.paymaster")) {
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2) {
			return;
		}

		local lowestPay = 1000;
		local lowestNoble;

		foreach (bro in brothers) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player)
				|| (bro.getFlags().get("IsPlayerCharacter"))) {
				continue;
			}

			if (bro.getDailyCost() < lowestPay
				&& bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble))
			{
				lowestNoble = bro;
				lowestPay = bro.getDailyCost();
			}
		}

		if (lowestNoble == null) {
			return;
		}

		local lowborn_candidates = [];

		foreach (bro in brothers) if (bro.getDailyCost() > lowestPay && bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn)	&& bro.getBackground().getID() != "background.slave") {
			lowborn_candidates.push(bro);
		}

		if (lowborn_candidates.len() == 0) {
			return;
		}

		this.m.Noble = lowestNoble;
		this.m.Lowborn = lowborn_candidates[this.Math.rand(0, lowborn_candidates.len() - 1)];
		this.m.Score = 7 + (lowestNoble.getSkills().hasTrait(::Legends.Trait.Greedy) ? 9 : 0);
	}
})
