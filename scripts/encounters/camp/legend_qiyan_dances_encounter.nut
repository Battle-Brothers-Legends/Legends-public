this.legend_qiyan_dances_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {
		Qiyan = null
	},
	function create() {
		this.m.ID = "encounter.legend_qiyan_dances";
		this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 25.0 * ::World.getTime().SecondsPerDay;
		this.createScreens();
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Start",
			Text = "[img]gfx/ui/events/event_39.png[/img]Sitting around the campfire with the rest of the company, your thoughts almost melt with the licking flames as you stare into the heap of glowing logs and bramble. Much of the company is equally transfixed as a quiet contemplation enthrals them to the flame and the thoughts of recent days. Suddenly, a shadow sucks you out of your trance and you look up to see %qiyan%, the company qiyan circling the flame, foot sweeping the ground between the company and the object of their focus. By design perhaps, most of the company has turned their focus to the southern woman, who with delicate yet deliberate movements is clearing a circle around the fire, kicking loose stones and outstretched legs to form a clear patch of earth. Sufficiently intrigued, the company obliges, pulling back and making space for the mysterious singer-dancer.\n\nHer stage now cleared and a suitably receptive audience acquired, the qiyan begins her show, leading with a low chant and a slow, rhythmic dance. She methodically circles the flame, casting shadows that creep onto and past each member of the company as her chant becomes a gentle song you can\'t understand, although it stirs a sense of loss and longing within you. After a few moments of this, you think the qiyan is almost done, but a sudden explosion in energy dispels such thoughts: her gentle circling of the flame has erupted into movements you can only describe as leaps as she repeatedly clears the flame in single, graceful movements. The awe of the company is clear- equal part impressed by her musical cadence and concerned that one wrong step would plunge her into the flames. As though playing into the fears of her crowd, %qiyan% edges closer to the flame, twirling and spinning in such elegant twists that she appeared as one with the flame itself, bursting forth from it to plaster shadows across the company, now thoroughly rapt by her dangerous and haunting performance. \n\nJust as you thought the dancer had in fact become the very flames she courted, a sudden wave of dust cakes the flame and tempers the raging storm within. A single movement signalled both the end of her dance and the flame\'s dominant presence before the company. With a simple bow and smile, the resplendent dancer thanks you for the company, and wishes everyone a good night. The crackling of the now subdued flame captures the mood well, with much of the company slack-jawed at the touching performance they just witnessed. Some take it as a good cue to leave for sleep, others remain by the fire, stunned into a new contemplation. Beside them, embers crack, and the fire begins to whisper back to life.",
			Image = "",
			List = [],
			Options = [{
				Text = "I\'m sure I could dance like that, back in my day...",
				getResult = @(_event) 0
			}],
			function start( _event ) {
				this.Characters.push(_event.m.Qiyan.getImagePath());

				this.List.extend([
					::Legends.EventList.changeMeleeDefense(_event.m.Qiyan, ::Math.rand(1, 2)),
					::Legends.EventList.changeResolve(_event.m.Qiyan, 2),
					::Legends.EventList.changeInitiative(_event.m.Qiyan, ::Math.rand(2,4)),
					::Legends.EventList.changeMood(_event.m.Qiyan, 2.0, "Pleased by her impressive performance for the company.")
				]);

				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (_event.m.Quian.getID() == bro.getID())
						continue;
					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, 1.0, "Amazed by the qiyan\'s mesmerising performance!");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
			}
		});
	}

	function isValid(_camp) {
		local roster = ::World.getPlayerRoster().getAll();
		if (roster.len() < 3)
			return false;
		local candidatesQiyan = roster.filter(@(_, _bro) _bro.getBackground().getID() == "background.legend_qiyan");
		if (!candidatesQiyan.len())
			return false;

		this.m.Qiyan = candidatesQiyan[::Math.rand(0, candidatesQiyan.len() - 1)];
		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push(["qiyan", this.m.Qiyan.getName()]);
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Qiyan.getGender(), "qiyan");
	}

	function onClear() {
		this.m.Qiyan = null;
	}
});
