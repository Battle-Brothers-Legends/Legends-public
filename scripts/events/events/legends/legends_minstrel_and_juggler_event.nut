this.legends_minstrel_and_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Juggler = null
	},
	function create() {
		this.m.ID = "event.legends.minstrel_and_juggler";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]Around the fire and among the drinks, %minstrel% the minstrel boasts to %juggler%.%SPEECH_ON%Oh ye tumbling fool, ye twirling baffoon! You claim to be so accurate to throw a knife betwixt the hairs on a poor sods head! You could never hit me! I, I have much experience dodging thrown objects, from rotten fruit to womens underwear, i've dodged it all in my time on stage. You could never hit me!%SPEECH_OFF% In one swift motion %minstrel% dodges as %juggler%\'s hands are quick to throw a knife. Another follows, and then another, before long the camp is strewn with thrown objects as they throw and dodge.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "An epic for all the wrong reasons!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Juggler.getImagePath());

				local rdef = _event.m.Minstrel.getCurrentProperties().getRangedDefense();
				if (::Math.rand(0, 20) > rdef) {
					if (::Math.rand(1, 2) == 1) {
						this.List.push(::Legends.EventList.changeRangedDefense(_event.m.Minstrel, 1));
					} else {
						this.List.push(::Legends.EventList.addInjury(_event.m.Minstrel, ::Const.Injury.Archery));
					}
				} else {
					if (::Math.rand(1, 3) == 1) {
						this.List.push(::Legends.EventList.changeRangedSkill(_event.m.Juggler, 1));
					}
					local brothers = ::World.getPlayerRoster().getAll();
					foreach (bro in brothers) {
						if (bro.getID() == _event.m.Minstrel.getID())
							continue;
						if (bro.getID() == _event.m.Juggler.getID())
							continue;

						local r = ::Math.rand(1, 20);
						if (r == 1) {
							this.List.push(::Legends.EventList.changeRangedDefense(bro, 1));
						}
						if (r == 2) {
							this.List.push(::Legends.EventList.addInjury(bro, ::Const.Injury.Archery));
						}
					}
				}
			}

		});
	}

	function onUpdateScore() {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates_minstrel = brothers.filter(@(_, bro) ::Legends.Backgrounds.has(bro, ::Legends.Background.Minstrel) && bro.getGender() == 0);
		if (candidates_minstrel.len() == 0)
			return;

		local candidates_juggler = brothers.filter(@(_, bro) ::Legends.Backgrounds.has(bro, ::Legends.Background.Juggler));
		if (candidates_juggler.len() == 0)
			return;

		this.m.Minstrel = candidates_minstrel[::Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Juggler = candidates_juggler[::Math.rand(0, candidates_juggler.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_juggler.len()) * 5;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler.getName()
		]);
	}

	function onClear() {
		this.m.Minstrel = null;
		this.m.Juggler = null;
	}

});
