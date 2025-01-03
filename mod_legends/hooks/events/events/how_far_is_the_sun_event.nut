::mods_hookExactClass("events/events/how_far_is_the_sun_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Historian") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Historian.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Historian.getID() || bro.getBackground().getID() == "background.historian"  || bro.getBackground().getID() == "background.legend_inventor" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_witch_commander"|| bro.getSkills().hasSkill("trait.bright"))
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
						if (bro.getEthnicity() == 1 || bro.getID() == _event.m.Monk.getID() || bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.legend_inventor" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_witch_commander" || bro.getBackground().getID() == "background.legend_necro" || bro.getBackground().getID() == "background.legend_necro_commander")
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
						} else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist)) {
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
						} else if (bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.mad")) {
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

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.legend_inventor" || bro.getBackground().getID() == "background.legend_seer"  || bro.getBackground().getID() == "background.legend_seer_commander" || bro.getSkills().hasSkill("perk.legend_scholar"))
				candidate_historian.push(bro);
			else if (bro.getBackground().getID() == "background.monk")
				candidate_monk.push(bro);
			else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist))
				candidate_cultist.push(bro);
			else if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_ranger_commander" || bro.getBackground().getID() == "background.legend_noble_ranged")
				candidate_archer.push(bro);
			else if (bro.getEthnicity() != 1 && bro.getBackground().getID() != "background.slave")
				candidate_other.push(bro);
		}

		if (candidate_other.len() == 0)
			return;

		local options = 0;

		if (candidate_historian.len() != 0)
			options++;

		if (candidate_monk.len() != 0)
			options++;

		if (candidate_cultist.len() != 0)
			options++;

		if (candidate_archer.len() != 0)
			options++;

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

		this.m.Other = candidate_other[this.Math.rand(0, candidate_other.len() - 1)];
		this.m.Score = options * 3;
	}
})
