this.legend_cannibal_recruitment <- this.inherit("scripts/events/event", {
	m = {
		Cannibal = null
	},
	function create() {
		this.m.ID = "event.legend_cannibal_recruitment";
		this.m.Title = "Strange Times";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_cannibal_recruitment.png[/img]You halt and turn your nose skyward, a thread of flavour is drifting on the wind — not grain or fruit, but instead more sickly sweet. Following the trail like a hungry pig leads to a ramshackle camp — inhabited by a lonely figure basked in the light of a campfire.\n\n A vast array of utensils is laid out in the same manner as a torturer places his instruments before beginning their work. The figure shuffles slightly, exchanging a ladle for a spoon.\n A branch crunches, the figure twitches somewhat, but does not rise or jump as you would expect.\n\n Their grisly voice drags out towards your hide. %SPEECH_ON%Ther\'s enough fer all of yer\'s %SPEECH_OFF% The figure starts stirring the pot gently with their finger. You emerge into the dim dancing light of the open fire, the smell is stronger now, but there\'s something else in the air that was not there before.\n\n With a hand on your weapon and approaching slowly, you enter the innermost ring of the fire. The light no longer dances, instead moping and tumbling on the stranger\'s face — who is still fixated on the stew mere inches from the tip of their rankling nose. They motion for you to sit down. The stranger, now half illuminated by the tired flame, moves from their spot to fix eyes with you. They stare and wait, as if mentally dissecting you.\n The thickness of the air starts to become noticeable. The stranger hangs a crooked grin. %SPEECH_ON%Yer want somethin\' \'ta eat?\n\nOr are ya lookin\' fer a real artist like merself?%SPEECH_OFF% With a smile the grin becomes uncomfortably wide.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We could use a good cook in %companyname%.",
					function getResult(_event) {
						this.World.getPlayerRoster().add(_event.m.Cannibal);
						this.World.getTemporaryRoster().clear();
						_event.m.Cannibal.onHired();
						return 0;
					}

				},
				{
					Text = "Leave the cook be.",
					function getResult(_event) {
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start(_event) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Cannibal = roster.create("scripts/entity/tactical/player");

				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
					_event.m.Cannibal.getFlags().add("PlayerSkeleton");
					_event.m.Cannibal.getFlags().add("undead");
					_event.m.Cannibal.getFlags().add("skeleton");
					_event.m.Cannibal.setStartValuesEx([::Legends.Background.Butcher]);
					::Legends.Traits.grant(_event.m.Cannibal, ::Legends.Trait.RacialSkeleton);
					::Legends.Traits.grant(_event.m.Cannibal, ::Legends.Trait.LegendFleshless);
				} else {
					_event.m.Cannibal.setStartValuesEx([::Legends.Background.Butcher]);
					::Legends.Traits.grant(_event.m.Cannibal, ::Legends.Trait.LegendCannibalistic);
					_event.m.Cannibal.getBackground().m.RawDescription = "{An odd man, %name% looks at your men oddly, as if an animal eyeing its next meal. | While speaking to %them%, %name% politely offers you some jerky, which you rapidly decline. | %name% is avoided by everyone else in the town, and %they% licks %their% lips hungrily as you approach. | %name% is a known name in the world, for they say wherever %they% goes, children seem to go missing. | Some men are murderers, some are monsters, %name% is a terrifying mix of both. | As you speak to %name%, a passing monk makes the sign of evil and holds %their% cross tight. | %name% claims to have exquisite tastes, taste in what, however, %they% does not say. | %name% is perhaps one of the friendliest people you\'ve ever met, yet you almost feel as if %they% is buttering you up. | You found %name% licking %their% fingers and pointedly not mentioning what meal was so delicious. | Many killers have excuses, but %name% can not bring up a single one when you realize what %they% is. | A sad creature, %name% seems perpetually hungry, yet refuses all of your food.} { %name% claims %they% simply wishes to serve man. | %name% assures you that your company will find no trouble from %them%. | %name% tells you one of the funniest jokes you\'ve ever heard, but even you find the subject matter too disturbing to justify laughter. | %They% loudly laughs at the mention of Gods, claiming that no living God would allow something like %them% to walk this world. | You hear the clattering of bones from within one of %their% pouch, to which %they% tells you are for the memories. | %Their% downright pleasant nature disturbs you, for there is nothing pleasant about what this %person% is. | The other brothers caution you about bringing %them% into the company, but %they% assures you that %they% will never harm his brothers. Unless ordered, at least. | You threaten to skewer %them% when %they% mentions how healthy you look, to which %they% quickly claims was just a passing compliment.} { Despite it all, %name% is good with a sword, and claims %they% rarely goes hungry. | A butcher like %them% will no doubt have little trouble carving the living. | %name% has doubtless had some experience butchering the living before. | Desperate times call for desperate measures, but how desperate are you to hire someone like this? | While some of %their%… skills… may be tempting, you know if you hire %them% you\'ll never sleep soundly as long as %they% lives. | The fact that creatures such as this exist makes you want to retch, but would many not say the same of you? | %They% eyes you queerly, as if %they% knows some secret joke that you never will. | When you are done speaking with %them%, %they% keeps talking. Quietly. To %themselves%. You do not like what you hear.}";
					_event.m.Cannibal.getBackground().buildDescription(true);
				}

				this.Characters.push(_event.m.Cannibal.getImagePath());
			}

		});
	}

	function onUpdateScore() {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		this.m.Score = 1;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"cannibal",
			this.m.Cannibal.m.Name
		]);
	}

	function onClear() {
		this.m.Cannibal = null;
	}
});

