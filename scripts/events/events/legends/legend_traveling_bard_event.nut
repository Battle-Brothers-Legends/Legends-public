this.legend_traveling_bard_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Town = null
	},
	function create() {
		this.m.ID = "event.legend_traveling_bard";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			//—
			ID = "A",
			Text = "%townImage%While walking about %townname%, you run into a man dressed more elegantly than you would expect — their actions do not convey they are a noble, but their speech and clothing would do if it wasn\'t for lute hanging over their shoulder. %SPEECH_ON%Welcome to %townname%! I\'m Theodore — and I am looking for some tall tales and brave deeds for my poems and songs. I\'m told you are the traveling and dangerous type and may have some stories to share? If so, your deeds will fall on the ears of many nobles in these lands, that I am sure of! All I need is a little money and as many tales as you can give me...%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				//500 = unlcoked 6 bros total, 750 = unlock 8 bros total. Most origins start at 300.
				//For context, an ambition completion is 100. Contract success is 25. Retreat/loss is -15. See 'world_assets' for more.
				Text = "Maybe something small for 150 crowns?",
				getResult = @(_event) "B"
			}, {
				Text = "I could think of a few things to tell for 250 crowns...",
				getResult = @(_event) "C"
			}, {
				Text = "I\'ve had a lot of adventures already, how about 350 crowns for all of them?",
				getResult = @(_event) "D"
			}, {
				Text = "Not interested, thanks.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				if (_event.m.Minstrel != null) {
					this.Options.push({
						Text = "Our bard, %minstrel% can tell it all better than I can!",
						getResult = @(_event) "E"
					});
				}
			}
		});
		this.m.Screens.push({
			//—
			ID = "B",
			Text = "%townImage%You start to describe why you started becoming a mercenary but quickly realise you don\'t have all that much to share. The bard has a dozen questions to help you along but you realise you have some way to go before you can share more.\n\n The bard nods a few times and writes down some rough notes before you hand over your crowns.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I hope this works.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeMoney(-150));
				this.List.push(::Legends.EventList.changeRenown(50));
			}

		});
		this.m.Screens.push({
			//—
			ID = "C",
			Text = "%townImage%Killing things seems easy when it comes to describing them. You start by giving a play-by-play of each part of a fight before you realise you may be here all day to describe what few battles you\'ve had so far. You eventually settle for just describing the men and beasts you have fought and slain and the dangers of the open road away from the towns and cities.\n\n The bard struggles to string something out of it but you eventually come to an agreement and hand over the crowns.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I hope this works.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeMoney(-250));
				this.List.push(::Legends.EventList.changeRenown(75));
			}

		});
		this.m.Screens.push({
			//—
			ID = "D",
			Text = "%townImage%You sit down with the bard and describe your adventures at length, albeit with some embellishment on your part — it\'s doubtful the bard has ever set foot off the roads, much less know what a ghoul is nor how large it is.\n\n Or how many limbs it has.\n\n Or what it smells like.\n\n The bard seems happy with what you have described and you hand over the crowns. Hopefully stories like this should prick the ears of the nobles.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I hope this works.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeMoney(-350));
				this.List.push(::Legends.EventList.changeRenown(100));
			}

		});
		this.m.Screens.push({
			//—
			ID = "E",
			Text = "[img]gfx/ui/events/event_92.png[/img]Barely before you finish announcing their name, %minstrel% jumps into the conversation as if you have introduced them on a stage. %minstrel% and and bard speak at great lengths about a variety of topics — from music to love to arts and even a short scriptwriting session of a new song the bard has been trying to complete for quite some time.\n Meanwhile you stand and wait for what seems like an eternity before %minstrel% finally gets to the point where they feel brave enough to ask for a \'minor\' discount — however they seem to have misinterpreted your earlier announcement and instead ask for it to be completely free.\n\n %minstrel% then produces a pre-written song of all the company\'s deeds in detail without missing a beat. They smile as they present it from a concealed pocket and hand it over on an arm outstretched to the bard with no regret whatsoever.\n\n The bard stares them down for what feels like an eternity until both parties laugh and smile. They poitn at each other while still laughing and say nothing as the bard gently takes the script which unfolds to several times it\'s orginal size.%SPEECH_ON%I\'ll see what I can do.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Don\'t embarrass me again.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeRenown(150));
			}
		});
	}

	function onUpdateScore() {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() <= 3) //fewer than or equal to 3 = event triggers
			return;

		if (this.World.Assets.getMoney() >= 500) return;

		if (!this.World.getTime().IsDaytime) return;

		local town = ::Legends.S.getClosestSettlement(@(_, t) t.isAlliedWithPlayer());
		if (town == null || town.getTile().getDistanceTo(::World.State.getPlayer().getTile()) <= 3) return;

		local candidates_minstrel = [];
		foreach (b in brothers) {
			if (::Legends.Backgrounds.has(b, ::Legends.Background.Minstrel)) {
				candidates_minstrel.push(b);
			}
		}

		if (candidates_minstrel.len() != 0) {
			this.m.Minstrel = candidates_minstrel[::Math.rand(0, candidates_minstrel.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = 5;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"town",
			this.m.Town.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
		_vars.push([
			"minstrel",
			this.m.Minstrel != null ? this.m.Minstrel.getName() : ""
		]);
	}

	function onClear() {
		this.m.Minstrel = null;
		this.m.Town = null;
	}
});

