::mods_hookExactClass("events/events/oldguard_becomes_drunkard_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_39.png[/img]You find %oldguard% nursing a rather large tankard next to a fire. In fact, it\'s not a tankard at all, but a wooden bucket filled with ale. A few more modest mugs are littered about %their_oldguard% feet. %They_oldguard% tips back, gulping from the bucket\'s lip. When %they_oldguard% sees you, %they_oldguard% tries to dress up, sloughing the foam off %their_oldguard% face and attempting a smile that quickly sloops into a drunken frown.%SPEECH_ON%Hey there, captain. Didn\'t mean for you to see me like this.%SPEECH_OFF%You set yourself down by the %person_oldguard% and ask how %they_oldguard% is doing.%SPEECH_ON%Being drunk.%SPEECH_OFF%Nodding, you reach for the bucket and the %person_oldguard% gives it up, though %their_oldguard% hands are shaped as if to still be holding it. You set the bucket down and ask again how %they_oldguard% is doing. %They_oldguard% finally drops %their_oldguard% hands into %their_oldguard% lap.%SPEECH_ON%Like shit. That\'s how I\'m feeling. First, %casualty% went down. Then %othercasualty%. I know there\'s been at least five or six others. Just dead men. Come and gone. I got memories of them talking, and memories of them screaming, and I can\'t have one without the other. But I\'m alright now cause right now I can\'t even think straight. If I can\'t unlearn a memory, I\'ll just go ahead and drown it. The ale does me well, heh.%SPEECH_OFF%With a sigh, you hand the bucket back to the %person_oldguard%. Eyes lost in the fire, %their_oldguard% mind lost in the past, %they_oldguard% says nothing else.";
		});
	}
	
	o.onUpdateScore = function ()
	{
		if (::World.getTime().IsDaytime)
			return;

		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 7)
			return;

		local numFallen = 0;

		foreach( f in fallen )
			if (!f.Expendable)
				numFallen = ++numFallen;

		if (numFallen < 7)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist) || ::Legends.Backgrounds.has(bro, ::Legends.Background.Slave))
				continue;

			if (bro.getLevel() >= 8 && !bro.getSkills().hasTrait(::Legends.Trait.Drunkard) && ::World.getTime().Days - bro.getDaysWithCompany() < fallen[0].Time && ::World.getTime().Days - bro.getDaysWithCompany() < fallen[1].Time && !bro.getSkills().hasTrait(::Legends.Trait.Player) && !bro.getFlags().get("IsPlayerCharacter"))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Oldguard = candidates[::Math.rand(0, candidates.len() - 1)];

		for( local i = 0; i < fallen.len(); i = ++i ) {
			if (fallen[i].Expendable)
			{}
			else if (this.m.OtherCasualty == null)
				this.m.OtherCasualty = fallen[i].Name;
			else if (this.m.Casualty == null)
				this.m.Casualty = fallen[i].Name;
			else
				break;
		}

		this.m.Score = numFallen - 2;
	}
})
