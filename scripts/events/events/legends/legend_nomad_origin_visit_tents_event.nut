this.legend_nomad_origin_visit_tents_event <- this.inherit("scripts/events/event", {
	m = {
		Recruit = null
	},
	function create() {
		this.m.ID = "event.legend_nomad_origin_visit_tents";
		this.m.Title = "Near another encampment...";
		this.m.Cooldown = 22.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			//— \'
			ID = "A",
			Text = "[img]gfx/ui/events/event_171.png[/img]There is a hum of activity in the desert — lookouts tail your approach but ultimately pose you no threat. Investigating further, there is a small mass of tents arranged as a caravan around a larger tent. These are your people, and you are greeted with a range of indifferance to open arms. \n\nThere looks to be more inside.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Enter the gathering of tents.",
				getResult = @(_event) "HubAllOptions"
			}, {
				Text = "Leave them be.",
				getResult = @(_event) "E"
			}],

			function start(_event) {}
		});
		this.m.Screens.push({
			//choose what to do
			ID = "HubAllOptions",
			Text = "[img]gfx/ui/events/event_175.png[/img]{There is a bustle of people within the tents, ferrying goods to-and-fro between tents as a cacophony assaults your hears as merchants haggle and old feuds are put to rest between groups — or extednded until further notice. \n\nDespite the noise, the company is warm and much is going on here despite the size.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Look for recruits.",
				getResult = @(_event) "Recruit"
			}, {
				Text = "Look Around.",
				getResult = @(_event) "Gander"
			}, {
				Text = "Leave this place.",
				getResult = @(_event) "E"
			}],
			function start(_event) {}

		});
		this.m.Screens.push({
			//fluff
			ID = "Recruit",
			Text = "[img]gfx/ui/events/event_171.png[/img]{A merchant of men sizes you up and greets you. After a brief exchange you learn he specialises in taking young men and women exiled from the city states and putting them to work as fighters. Your situations are very similar, but being a merchant more than an idealist, the man refuses to part with his prodigies.\n\n A flash of gold changes his mind, and he informs that you may buy one of his fighters, but for a cost of 350 crowns.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Purchase the services of a Nomad fighter.",
					function getResult(_event) {
						local roster = this.World.getTemporaryRoster();
						_event.m.Recruit = roster.create("scripts/entity/tactical/player");
						_event.m.Recruit.onHired();
						_event.m.Recruit.setStartValuesEx([::Legends.Background.Nomad]);
						return "PostRecruitPurchase";
					}
				},
				{
					Text = "Purchase the services of a Nomad bowman.",
					function getResult(_event) {
						local roster = this.World.getTemporaryRoster();
						_event.m.Recruit = roster.create("scripts/entity/tactical/player");
						_event.m.Recruit.onHired();
						_event.m.Recruit.setStartValuesEx([::Legends.Background.NomadRanged]);
						return "PostRecruitPurchase";
					}
				},
				{
					Text = "Return to the main gathering.",
					getResult = @(_event) "HubAllOptions"
				}
			],
			function start(_event) {}
		});

		this.m.Screens.push({
			ID = "PostRecruitPurchase",
			Text = "[img]gfx/ui/events/event_171.png[/img]{The merchant seems pleased, and after a brief exchange of words, you find %Recruit% in your employ. The merchant quickly departs.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Return to the main gathering.",
				getResult = @(_event) "HubNoRecruit"
			}],
			function start(_event) {
				this.Characters.Recruit(_event.m.Dude.getImagePath());
				this.List.push(::Legends.EventList.changeMoney(-350));
				this.List.push({
					id = 11,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]%Recruit%[/color] joins you"
				});
			}
		});

		this.m.Screens.push({
			//fluff
			ID = "HubNoRecruit",
			Text = "[img]gfx/ui/events/event_161.png[/img]{With the merchant gone, there is still a little more to see — however tents are being unpitched and larger warbands have already moved off...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Look Around.",
				getResult = @(_event) "Gander"
			}, {
				Text = "Leave this place.",
				getResult = @(_event) "E"
			}],
			function start(_event) {}
		});

		this.m.Screens.push({
			//fluff
			ID = "Gander", // | —
			Text = "[img]gfx/ui/events/event_05.png[/img]{You take a look around the back of a tent, you see two cloaked figures with silver masks exchanging something. They do not see you, but you make an effort to forget what you just saw. | Away from the rest of the tents, you notice a man buried neck deep in the scorching sand. After investigating further your empathy evaporates — this man is dressed as a conscript with the words %SPEECH_ON%T R A I T O R%SPEECH_OFF% carved into his forehead. You walk back to the camp. | One of the larger warbands gets in a scuffle with some merchants. The peacekeepers quickly find the ringleaders and subdue them — the only casualty is a few egos | An enterprising merchant rests outside on a mortar, an auction is being held — but any bids for the machine are quickly recanted thanks to the persuasive nature of some of the older, more powerful warlords in the crowd. \n\nThe merchant leaves without a crown for the machine as various tribes scorn him out of the gathering. | Someone bumps into you, offering wine. You look inside the jug to see a mixure that looks more solid than liquid. You politely decline. | A man is tied to a post within one of the smaller tents — a masked man throws knives at him as he begs for his life. You decide not to intervene. | A few crownlings have taken up camp outside the concourse of tents. When asked about, you are mostly met with indigant shrugs. Whoever these northerners are, they are being vouched for and protected...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Return to the main gathering.",
				getResult = @(_event) "HubAllOptions"
			}],
			function start(_event) {}
		});

		this.m.Screens.push({
			//Tail
			ID = "E",
			Text = "[img]gfx/ui/events/event_150.png[/img]{You have seen everything to see, you make your exit and get back on the path.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "We should return someday...",
				getResult = @(_event) 0
			}],
			function start(_event) {}
		});
	}

	function onUpdateScore() {
		if (this.World.Assets.getOrigin().getID() != "scenario.legends_nomad") //only happens with this origin
			return;

		if (this.World.Assets.getMoney() < 1000)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 1)
			return;

		local currentTile = this.World.State.getPlayer().getTile();
		local locations = this.World.EntityManager.getLocations();
		local nearSite = false;

		foreach (v in locations) {
			///Possible other locations: nomad_tent_city ~~ nomad_hidden_camp ~~ nomad_tent_city ~~ nomad_ruins
			if (v.getTypeID() == "location.nomad_tents" && v.getTile().getDistanceTo(currentTile) < 3) {
				nearSite = true;
				break;
			}
		}

		if (!nearSite)
			return;

		this.m.Score = 8;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {}

	function onClear() {
		this.m.Recruit = null;
	}
});

