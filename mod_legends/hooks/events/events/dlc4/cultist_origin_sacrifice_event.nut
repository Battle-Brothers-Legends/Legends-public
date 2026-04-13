::mods_hookExactClass("events/events/dlc4/cultist_origin_sacrifice_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_140.png[/img]{%sacrifice% is bound and put to the fire. The smell of burnt pork fills the air and the faithful around you rejoice with tears in their eyes. You see a face twisting in the smoke of the sacrifice, a knowing visage that approves. The company are emboldened. | %sacrifice% is chopped to pieces until they are but a torso and head. The blood has emptied across the ground and yet there\'s still light in the eyes and a perverse smile upon the face. You take an axehead and run it into the throat until %sacrifice% is no more. Every bodypart is separated and put upon a pole, caked in grease, and lit aflame. You and the faithful dance beneath the pyres as the night comes and the night goes. | The procession is such: %sacrifice% is flayed alive and pierced with sharpened sticks through each limb and held aloft, spread-eagled over a fire which cooks the sacrifice until death. The faithful watch %sacrifice%\'s passing in silence, but as soon as one of the charred limbs breaks and collapses  the corpse into the flames the faithful cheer and hoot and holler, some pray, others roll around in the ashes of %sacrifice%, some licking it off their fingertips like it were sweets. It is a good night. | A long stick is pierced through %sacrifice% from posterior to out the side of the neck. The sacrifice is tilted up into the sky and held there by one person while others use long spears to stab %sacrifice% through until the corpse is the apex of an uncovered tent. The conical corpse is then covered with grass and mud until there stands a tipi, a torso and head of %sacrifice% all that remains above, and should you enter the tent you would find legs dangling from its ceiling. The monument should stand as an omen for those to come, and a sign that they should come to accept that which awaits us all.}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Sacrifice.getImagePath());
					local dead = _event.m.Sacrifice;
					::Legends.addFallen(dead, "Sacrificed to Davkul");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Sacrifice.getName() + " has died"
					});
					_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
					this.World.getPlayerRoster().remove(_event.m.Sacrifice);
					local brothers = this.World.getPlayerRoster().getAll();
					local hasProphet = false;

					foreach( bro in brothers ) {
						if (bro.getSkills().hasTrait(::Legends.Trait.CultistProphet))
						{
							hasProphet = true;
							break;
						}
					}

					// Keep two separe lists so candle changes can be displayed first
					local moodChanges = [];
					local candleChanges = [];

					foreach( bro in brothers ) {
						if (bro.getSkills().hasEffect(::Legends.Effect.LegendAnimatedPlayerProperties))
							continue;

						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist | this.Const.BackgroundType.Cultist) || bro.getBackground().getID() == "background.legend_commander_necro" || bro.getBackground().getID() == "background.legend_necro" || bro.getBackground().getID() == "background.legend_vala" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_commander_witch" || bro.getBackground().getID() == "background.legend_cannibal" || bro.getBackground().getID() == "background.legend_donkey")  {
							bro.improveMood(3.0, "Appeased Davkul");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral) {
								moodChanges.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}

							if (this.Math.rand(1, 100) > 50)
								continue;

							local skills = bro.getSkills();
							local skill;

							if (skills.hasTrait(::Legends.Trait.CultistProphet))
								continue;
							else if (skills.hasTrait(::Legends.Trait.CultistChosen)) {
								if (hasProphet)
									continue;

								hasProphet = true;
								this.updateAchievement("VoiceOfDavkul", 1, 1);
								::Legends.Traits.remove(skills, ::Legends.Trait.CultistChosen);
								::Legends.Actives.grant(bro, ::Legends.Active.VoiceOfDavkul);
								skill = ::Legends.Actives.get(bro, ::Legends.Active.VoiceOfDavkul);
								candleChanges.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " has received " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});

								::Legends.Traits.grant(skills, ::Legends.Trait.CultistProphet);
							} else if (skills.hasTrait(::Legends.Trait.CultistDisciple)) {
								::Legends.Traits.remove(skills, ::Legends.Trait.CultistDisciple);
								skill = ::Legends.Traits.grant(skills, ::Legends.Trait.CultistChosen);
							} else if (skills.hasTrait(::Legends.Trait.CultistAcolyte)) {
								::Legends.Traits.remove(skills, ::Legends.Trait.CultistAcolyte);
								skill = ::Legends.Traits.grant(skills, ::Legends.Trait.CultistDisciple);
							} else if (skills.hasTrait(::Legends.Trait.CultistZealot)) {
								::Legends.Traits.remove(skills, ::Legends.Trait.CultistZealot);
								skill = ::Legends.Traits.grant(skills, ::Legends.Trait.CultistAcolyte);
							} else if (skills.hasTrait(::Legends.Trait.GloriousQuickness)) {
								::Legends.Traits.remove(skills, ::Legends.Trait.GloriousQuickness);
								skill = ::Legends.Traits.grant(skills, ::Legends.Trait.CultistZealot);
							} else {
								skill = ::Legends.Traits.grant(skills, ::Legends.Trait.CultistFanatic);
							}

							if (skill != null) {
								candleChanges.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							}
						} else if (!bro.getSkills().hasTrait(::Legends.Trait.Mad)) {
							bro.worsenMood(2.5, "Horrified by the sacrifice of " + _event.m.Sacrifice.getName());

							if (bro.getMoodState() < this.Const.MoodState.Neutral) {
								moodChanges.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}

					foreach (_, c in candleChanges) {
						this.List.push(c);
					}
					foreach (_, c in moodChanges) {
						this.List.push(c);
					}

				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Wildmen)
			return;

		if (this.World.getTime().Days <= 5)
			return;

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates = [];
		foreach (bro in brothers) {
			if (bro.getSkills().hasSkill("background.legend_husk") || bro.getSkills().hasSkill("background.legend_magister")) //Will not sacrifice any backgrounds using these IDs
				continue;

			candidates.push(bro);
		}

		if (candidates.len() < 3)
			return;

		candidates.sort(function ( _a, _b ) {
			if (_a.getXP() < _b.getXP())
				return -1;
			else if (_a.getXP() > _b.getXP())
				return 1;
			return 0;
		});
		local r = this.Math.rand(0, this.Math.min(2, candidates.len() - 1));
		this.m.Sacrifice1 = candidates[r];
		candidates.remove(r);
		r = this.Math.rand(0, this.Math.min(2, candidates.len() - 1));
		this.m.Sacrifice2 = candidates[r];
		this.m.Score = 50 + (this.World.getTime().Days - this.m.LastTriggeredOnDay);
	}
})
