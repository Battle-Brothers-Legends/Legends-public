::mods_hookExactClass("events/events/how_far_is_the_sun_event", function(o) {
	o.m.Dervish <- null;
	o.m.Southerner <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					if (_event.m.Dervish != null && this.Options.len() < 6) {
						this.Options.insert(this.Options.len() - 1, {
							Text = "Our southern ascetic has lived their life under their Gilder\'s embrace, surely they have an idea",
							getResult = @(_event) "Dervish"
						});
					}
					if (_event.m.Southerner != null && this.Options.len() < 6) {
						this.Options.insert(this.Options.len() - 1, {
							Text = "Our %southerner% from the learned south must surely have gleamed the truth of this?",
							getResult = @(_event) "Southerner"
						});
					}
				}
			}
			if (s.ID == "Historian") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Historian.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Historian.getID() || bro.getBackground().getID() == "background.historian"  || bro.getBackground().getID() == "background.legend_inventor" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_commander_witch"|| bro.getSkills().hasTrait(::Legends.Trait.Bright))
							continue;

						if (this.Math.rand(1, 100) <= 33) {
							bro.improveMood(0.5, "Entertained by " + _event.m.Historian.getName() + "\'s silly notions about the sun");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
			if (s.ID == "Monk") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getEthnicity() == 1 || bro.getID() == _event.m.Monk.getID() || bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist) || bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.legend_inventor" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_commander_witch" || bro.getBackground().getID() == "background.legend_necro" || bro.getBackground().getID() == "background.legend_commander_necro")
							continue;

						if (this.Math.rand(1, 100) <= 33) {
							bro.improveMood(0.5, "Encouraged by " + _event.m.Monk.getName() + "\'s preaching");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
			if (s.ID == "Cultist") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Cultist.getID()) {
							bro.improveMood(1.0, "Relished the opportunity to talk about the dying sun");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						} else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
							bro.improveMood(0.5, "Relished " + _event.m.Cultist.getName() + "\'s speech about the dying sun");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						} else if (bro.getEthnicity() == 1) {
							bro.worsenMood(1.0, "Angry about the heretical ramblings of " + _event.m.Cultist.getName());

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						} else if (bro.getSkills().hasTrait(::Legends.Trait.Superstitious) || bro.getSkills().hasTrait(::Legends.Trait.Mad)) {
							bro.worsenMood(1.0, "Terrified at the prospect of a dying sun");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
			if (s.ID == "Archer") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%archer% takes the challenge, grabbing his bow and a couple of arrows. He licks his finger and holds it up.%SPEECH_ON%Wind\'s right for a good star shootin\'.%SPEECH_OFF%The archer nocks an arrow, draws, and takes aim. The blistering light is instantly blinding.%SPEECH_ON%Fark, I can\'t see shit.%SPEECH_OFF%His aim wobbles as dark spots take over his vision. The arrow is loosed and sails wide of the sun. Real wide. They look at the company, eyes dimmed, hands out as he tries to steady himself while his sight returns.%SPEECH_ON%Did I hit it?%SPEECH_OFF%%otherbrother% hides his chuckling.%SPEECH_ON%Right on the button!%SPEECH_OFF%The men burst into laughter.";
			}
		}

		this.m.Screens.push({
			ID = "Southerner",
			Text = "[img]gfx/ui/events/event_161.png[/img]%southerner% the southerner shakes %their_southerner% head and addresses the group. %SPEECH_ON%I\'m not sure on the specifics, but I have heard some varied ideas from the south. Apparently, learned men in their halls of wisdom know the exact distance, but greedily hoard it. Others claim the wise scholars lie, and that the sun cannot be measured. I don\'t really know, but I hear it can cause upset amongst the elite of the south. Street preachers claim that the sun is personal to those who view it, but I don\'t see how that can be true…%SPEECH_OFF%A few brothers grumble at such inconclusive answers, with one brother interrupting the southerner before they can continue.%SPEECH_ON%So, they don\'t have a farkin\' clue then?%SPEECH_OFF%The southerner ponders it for a moment, then agrees. Many of the company erupt into laughter and perhaps take pleasure in the fact that even the learned men of the south struggle over this age-old question. To their credit, the southerner joins in with the cheer, themselves likely having come to the blunt yet potent conclusion many times before: We don\'t have a farkin\' clue.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "All those tomes, yet so few answers...",
				getResult = @(_event) 0
			}],
			function start( _event ) {
				this.Characters.push(_event.m.Southerner.getImagePath());

				local entry = ::Legends.EventList.changeMood(_event.m.Southerner, 1.0, "Happy to share tales of southern beliefs");
				if (_event.m.Southerner.getMoodState() >= this.Const.MoodState.Neutral)
					this.List.push(entry);

				foreach (bro in ::World.getPlayerRoster().getAll().filter(@(_idx, _bro) _bro.getEthnicity() != 1)) {
					if (bro.getID() == _event.m.Southerner.getID())
						continue;

					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, 1.5, "Amused by tales of southern indecision");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
			}
		});

		this.m.Screens.push({
			ID = "Dervish",
			Text = "[img]gfx/ui/events/event_161.png[/img]%Dervish% the dervish lets out a plain smile, as though they were waiting for such a question for some time. They place themself before the rest of the company and open their arms towards the sun, graciously absorbing its heat for %themselves_dervish%. Confidently, they proclaim.%SPEECH_ON%The answer you seek cannot come from others- only you can know how close you are to our guiding sun.%SPEECH_OFF%A few of the company look on visibly taken aback and confused. One brother manages to capture the mood perfectly with a loud \'huh?\'. The ascetic, still basking in the sun, elaborates their point.%SPEECH_ON%The Gilder above grants us the sun, both as a reward and punishment- the same sun that warms your bones on a cold day can scorch your skin. How close the sun is depends on your relationship with the Gilder: if you serve them loyally and well, the sun reaches balance and offers sublime radiance. If you are wicked and resist the Gilder, the sun ebbs and flows between scorching heat and frigid cold.%SPEECH_OFF%A few brothers scoff at such a silly notion, a sun that is personal to everyone beneath it? Many quickly shrug it off and go back to their own theories, some pulling at their collars and wiping sweat from their brow. The dervish, pleased with their speech, returns to the company. You spot a faint smile, but notably not a single bead of sweat on them as they gleefully listen to the company bounce between their own theories, like a father listening to nonsense ramblings of his children.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "It is a rather hot day, isn\'t it?",
				getResult = @(_event) 0
			}],
			function start( _event ) {
				this.Characters.push(_event.m.Dervish.getImagePath());

				this.List.push(::Legends.EventList.changeResolve(_event.m.Dervish, 3));
				local entry = ::Legends.EventList.changeMood(_event.m.Dervish, 2.0, "Bathed in the Gilder\'s resplendent light");
				if (_event.m.Dervish.getMoodState() >= this.Const.MoodState.Neutral)
					this.List.push(entry);
			}
		});
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidate_historian = [];
		local candidate_monk = [];
		local candidate_cultist = [];
		local candidate_archer = [];
		local candidate_other = [];
		local candidate_southerner = [];
		local candidate_dervish = [];

		foreach (bro in brothers) {
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendScholar) || ::Legends.S.oneOf(bro.getBackground().getID(),
				"background.historian",
				"background.legend_inventor",
				"background.legend_witch",
				"background.legend_commander_witch"
			)) {
				candidate_historian.push(bro);
			} else if (bro.getBackground().getID() == "background.monk") {
				candidate_monk.push(bro);
			} else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
				candidate_cultist.push(bro);
			} else if (::Legends.S.oneOf(bro.getBackground().getID(),
				"background.hunter",
				"background.poacher",
				"background.sellsword",
				"background.legend_ranger",
				"background.legend_commander_ranger",
				"background.legend_noble_ranged"
			)) {
				candidate_archer.push(bro);
			} else if (::Legends.S.oneOf(bro.getBackground().getID(),
				"background.nomad",
				"background.shepherd",
				"background.manhunter",
				"background.legend_qiyan",
				"background.gladiator",
				"background.legend_muladi",
				"background.belly_dancer",
				"background.assassin_southern",
				"background.legend_conscript"
			)) {
				candidate_southerner.push(bro);
			} else if (bro.getBackground().getID() == "background.legend_dervish") {
				candidate_dervish.push(bro);
			} else if (bro.getEthnicity() != 1) {
				candidate_other.push(bro);
			}
		}

		if (candidate_other.len() == 0)
			return;

		local options = 0;
		options += ::Math.min(1, candidate_historian.len());
		options += ::Math.min(1, candidate_monk.len());
		options += ::Math.min(1, candidate_cultist.len());
		options += ::Math.min(1, candidate_archer.len());
		options += ::Math.min(1, candidate_southerner.len());
		options += ::Math.min(1, candidate_dervish.len());
		options += ::Math.min(1, candidate_historian.len());

		if (options < 2)
			return;

		if (candidate_historian.len() != 0)
			this.m.Historian = candidate_historian[this.Math.rand(0, candidate_historian.len() - 1)];

		if (candidate_monk.len() != 0)
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];

		if (candidate_cultist.len() != 0)
			this.m.Cultist = candidate_cultist[this.Math.rand(0, candidate_cultist.len() - 1)];

		if (candidate_archer.len() != 0)
			this.m.Archer = candidate_archer[this.Math.rand(0, candidate_archer.len() - 1)];

		if (candidate_southerner.len() != 0)
			this.m.Southerner = candidate_southerner[this.Math.rand(0, candidate_southerner.len() - 1)];

		if (candidate_dervish.len() != 0)
			this.m.Dervish = candidate_dervish[this.Math.rand(0, candidate_dervish.len() - 1)];

		this.m.Other = candidate_other[this.Math.rand(0, candidate_other.len() - 1)];
		this.m.Score = options * 3;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		if (this.m.Dervish != null) {
			_vars.push(["dervish", this.m.Dervish.getNameOnly()]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dervish.getGender(), "dervish");
		}
		if (this.m.Southerner != null) {
			_vars.push(["southerner", this.m.Southerner.getNameOnly()]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Southerner.getGender(), "southerner");
		}
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Dervish = null;
		this.m.Southerner = null;
	}
});
