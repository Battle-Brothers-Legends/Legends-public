this.legend_golden_goose_superstitious <- this.inherit("scripts/events/event", {
	m = {
		Superstitious = null,
		Other = null,
		Greedy = null,
		Thief = null
	},

	function create() {
		this.m.ID = "event.legend_golden_goose_superstitious";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]While making your evening rounds, a curious sound draws your attention - as if someone is rummaging through the company's inventory tent. You cautiously draw your blade and approach, while taking careful account of your surroundings.\n\nPeeking around a corner, you spot %superstitiousbro%, carrying a heavy sack towards the tent's entrance. %They_superstitious% is completely absorbed by the task, nervously glancing over %their_superstitious% shoulder but completely missing your presence in the shadows.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Curious. Let's see where this goes.",
					getResult = @(_event)"B"
				},
				{
					Text = "You there! Stop at once!",
					getResult = @(_event)"C"
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Superstitious.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_39.png[/img]You decide to let the scene unfold, watching as %superstitiousbro% enters the tent with %their_superstitious% mysterious cargo. As %they_superstitious% disappears inside, you resolve to hold your position, keeping a close eye on the flap. Moments later, %they_superstitious% reemerges, hands empty. %They_superstitious% crouches next the entrance and starts picking at %their_superstitious% teeth with a piece of wood, visibly less tense than before.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's have an innocent peek around the back.",
					getResult = @(_event)"D"
				},
				{
					Text = "Having trouble sleeping?",
					getResult = @(_event)"E"
				},
				{
					Text = "Huh. Guess it was innocent after all.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Superstitious.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_39.png[/img]Startled, the mercenary drops the sack. Golden coins scatter across the dirt as %they_superstitious% spins around, mouth agape wide.%SPEECH_ON%Oh, ye scared me good 'ere boss! Scared me right out me farkin' boots.%SPEECH_OFF%You sheathe your weapon and wait as %person_superstitious% scrambles to gather the coins.%SPEECH_ON%Don\'t give me that look boss, this \'ere just me own pay, gathered over me time in the 'ompany. %otherbro% whistled inside the tent earlier, see? And everyone knows whistlin' indoors blows yer coin away. So I gotta watch mine and 'ompanies inventory tonight!%SPEECH_OFF%The way %they_superstitious% states the bit about whistling almost has you believing it for a second too. You decide it's better not to argue with that kind of logic.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I am holding you responsible if anything goes missing.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Superstitious.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_legend_golden_goose.png[/img]You step back into the shadows and put your steel away. Once you are sure the coast is clear, you circle around to the back of the tent and after making sure nobody is watching, carefully lift the canvas to take a peek inside. You instantly spot the sack the %sibling_superstitious% brought in. It sits right in the middle of the floor, brimming with coins and perched firmly atop of it is the company's Golden Goose.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to have a word with %person_superstitious%.",
					getResult = @(_event)"E"
				},
				{
					Text = "Whatever this is, I have seen enough.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				if (_event.m.Thief != null) {
					this.Options.insert(1, {
						Text = "Let's have %thief%'s teach %them_superstitious% a lesson.",
						getResult = @(_event)"F"
					});
				}
				if (_event.m.GreedyBro != null) {
					this.Options.insert(1, {
						Text = "Let's see what %greedybro% thinks about this curiosity.",
						getResult = @(_event)"G"
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_legend_golden_goose.png[/img]You get back to the front of the tent. As you step out of the shadows, the mercenary jumps up, startled.%SPEECH_ON%Wha-oh! Boss! I... uh, couldn't sleep, sir! Just gettin' some fresh air, aye, as you do yerself if I may say so meself, sir.%SPEECH_OFF%Ignoring %their_superstitious% stammering, you rush past the mercenary and enter the tent. You immediately spot the sack the %sibling_superstitious% entered with on the floor, brimming with gold, the company's Golden Goose perched directly on top of it. You turn around towards %superstitiousbro%, who is nervously wringing %their_superstitious% hands and do your best to put on a mighty frown.%SPEECH_ON%Listen 'ere, boss... %otherbro% said gold brings more gold, right? Like calls to like! So I figured, why not put our shiny bird in a little nest? Help the luck a bit, as it 'ere.%SPEECH_OFF%%They_superstitious% smiles uncertainly.\n\nYou shake your head, grab the Goose and walk away.%SPEECH_ON%What a load of shite.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And better keep that sack of yours out of the sight of the others.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Superstitious.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.Superstitious, -0.5, "Felt bad about the Golden Goose business");
				if (_event.m.Superstitious.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}

			}
		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_33.png[/img]You back away quietly and head straight for %thief%'s bedroll. You quickly explain the situation, and the thief's eyes light up with a mischievous glee.\n\nThe plan is simple. While you return to the front of the tent to distract %superstitiousbro% with some idle chatter, %thief% slips in through the back. A few moments later, over the superstitious guard's rambling, you hear the faint hoot of an owl and know that the job is over.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's see the payoff.",
					getResult = @(_event)"H"
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Superstitious.getImagePath());
				this.Characters.push(_event.m.Thief.getImagePath());
			}
		});

		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_legend_golden_goose.png[/img]You decide to fetch %greedybro%, a %person_greedy% who talks only about money. %They_greedy% inspects the setup through the gap in the tent and strokes %their_greedy% chin thoughtfully.%SPEECH_ON%Capital requires capital to grow, captain. It's a fundamental rule of commerce. Even supernatural commerce.%SPEECH_OFF%You decide to leave the sack right where it is. All of sudden, just as you were both turning to leave, you hear a heavy, metallic clink. You look back to see a freshly minted, oversized golden coin roll off the top of the pile.\n\nIt seems wealth really does breed wealth.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well, I'll be damned.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Greedy.getImagePath());
				::Legends.Items.Effects.GoldenGooseGoldPerDay += 20;

				this.List.push({
					id = 1,
					icon = "ui/items/loot/golden_goose.png",
					text = "The Golden Goose will now lay more gold"
				});

				local entry = ::Legends.EventList.changeMood(_event.m.Superstitious, 1.0, "%Their% superstition was proven right");
				if (_event.m.Superstitious.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}

				entry = ::Legends.EventList.changeMood(_event.m.Greedy, 1.5, "Realised %their% greedy dreams");
				if (_event.m.Greedy.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}
			}
		});

		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_33.png[/img]Before the night is over, curiosity gets the better of %superstitiousbro%. You hear a muffled yelp from inside the tent, followed by a loud stream of curses. You and several other brothers, including a grinning %thief%, gather around the entrance.\n\nInside, %superstitiousbro% is frantically sorting through %their_superstitious% sack, which is now half-filled with crushed eggshells and polished river stones. \n\n%SPEECH_ON%The luck! They took me coin and left me with garbage!%SPEECH_OFF%%They_superstitious% wails. The gathered mercenaries erupt into roaring laughter. %thief% tosses you a pouch with a wink, having already secured a tidy profit for %themselves_thief%.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A fool and %their_superstitious% money are easily parted.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.SuperstitiousBro.getImagePath());
				this.Characters.push(_event.m.Thief.getImagePath());

				local entry = ::Legends.EventList.changeMood(_event.m.SuperstitiousBro, -1.0, "Lost money during the Golden Goose business");
				if (_event.m.SuperstitiousBro.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}

				entry = ::Legends.EventList.changeMood(_event.m.Thief, 1.0, "Pulled a profitable prank");
				if (_event.m.SuperstitiousBro.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}

				this.List.push(::Legends.EventList.changeMoney(::Math.max(50, _event.m.SuperstitiousBro.getDailyCost() * _event.m.SuperstitiousBro.getDaysWithCompany() / 10)));
			}
		});
	}

	function onUpdateScore() {
		if (::World.Flags.get("IsGoldenGoose") == false) {
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();
		if (brothers.len() < 3) {
			return;
		}
		local candidates_superstitious = brothers.filter(@(_, _bro)(::Legends.Traits.has(_bro, ::Legends.Trait.Superstitious) && _bro.getDaysWithCompany() > 50));
		if (candidates_superstitious.len() == 0) {
			return;
		}
		this.m.Superstitious = candidates_superstitious[::Math.rand(0, candidates_superstitious.len() - 1)];

		local self = this;
		local brothersWithoutSuperstitious = brothers.filter(@(_, _bro)(_bro.getID() != self.m.SuperstitiousBro.getID()));
		this.m.Other = brothersWithoutSuperstitious[::Math.rand(0, brothersWithoutSuperstitious.len() - 1)];

		local candidates_greedy = brothers.filter(@(_, _bro)(::Legends.Traits.has(_bro, ::Legends.Trait.Greedy)));
		if (candidates_greedy.len() > 0) {
			this.m.Greedy = candidates_greedy[::Math.rand(0, candidates_greedy.len() - 1)];
		}

		local candidates_thief = brothers.filter(@(_, _bro)(::Legends.Backgrounds.has(_bro, ::Legends.Background.Thief)));
		if (candidates_thief.len() > 0) {
			this.m.Thief = candidates_thief[::Math.rand(0, candidates_thief.len() - 1)];
		}
		this.m.Score = 10;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"superstitiousbro",
			this.m.Superstitious.getName()
		]);
		_vars.push([
			"otherbro",
			this.m.Other.getName()
		]);
		_vars.push([
			"greedybro",
			this.m.Greedy != null ? this.m.Greedy.getName() : ""
		]);
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getName() : ""
		]);
	}

	function onClear() {
		this.m.Superstitious = null;
		this.m.Other = null;
		this.m.Greedy = null;
		this.m.Thief = null;
	}
});
