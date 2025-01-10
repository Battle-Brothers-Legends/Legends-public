::mods_hookExactClass("events/events/troublemakers_bully_peasants_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event )
				{
					if (_event.m.Peacekeeper != null) {
						this.Options.push({
							Text = "%peacekeeperfull%, see if you can calm %troublemaker% with your wisdom.",
							function getResult( _event ) {
								return this.Math.rand(1, 100) <= 70 ? "E" : "F";
							}
						});
					}

					this.World.Assets.addMoralReputation(-1);

					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
					f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your company caused havoc in town");
					this.Characters.push(_event.m.Troublemaker.getImagePath());
				}
			}
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Troublemaker.getImagePath());
					this.World.Assets.addMoralReputation(-3);

					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
					local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
					f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your company caused havoc in town");
					_event.m.Troublemaker.improveMood(1.0, "Bullied the peasantfolk");

					if (_event.m.Troublemaker.getMoodState() >= this.Const.MoodState.Neutral)
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Troublemaker.getMoodState()],
							text = _event.m.Troublemaker.getName() + this.Const.MoodStateEvent[_event.m.Troublemaker.getMoodState()]
						});
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_30.png[/img]You look at the peasant who hailed you down.%SPEECH_ON%Who are you, peasant, to tell me or my company what to do?%SPEECH_OFF%The man takes a step back, stammering something about \'only trying to help.\' Laughing, you tell your mercenaries to take what they want. If this village has no respect for the authority of armed warriors, then you will have to teach them that respect.\n\nWomen scream and bundle up their children as the order leaves your tongue. They run off and a few men join them. Other men stay behind, protecting their homes, but the %companyname% makes quick work of their modest defenses. Your mercenaries are soon pillaging each and every home, taking what they can with roaring laughter. Today is a good day.";
				s.start <- function ( _event )
				{
					this.Characters.push(_event.m.Troublemaker.getImagePath());
					this.World.Assets.addMoralReputation(-5);

					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases greatly"
					});

					local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
					f.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You pillaged the town");
					local money = this.Math.rand(100, 500);
					this.World.Assets.addMoney(money);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getSkills().hasTrait(::Legends.Trait.Bloodthirsty) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
						{
							bro.improveMood(1.0, "Enjoyed raiding and pillaging");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
						else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && this.Math.rand(1, 100) <= 75)
						{
							bro.worsenMood(1.0, "Was appalled by the company\'s conduct");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
			if (s.ID == "F") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Troublemaker.getImagePath());
					this.Characters.push(_event.m.Peacekeeper.getImagePath());
					this.List.push({
						id = 10,
						icon = "ui/icons/relation.png",
						text = _event.m.Troublemaker.getName() + " and " + _event.m.Peacekeeper.getName() + " grow distant"
					});
					local injury = _event.m.Peacekeeper.addInjury(this.Const.Injury.Knockout);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Peacekeeper.getName() + " suffers " + injury.getNameOnly()
					});
					_event.m.Peacekeeper.worsenMood(2.0, "Was humiliated in front of the company");

					if (_event.m.Peacekeeper.getMoodState() < this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Peacekeeper.getMoodState()],
							text = _event.m.Peacekeeper.getName() + this.Const.MoodStateEvent[_event.m.Peacekeeper.getMoodState()]
						});
					}
				}
			}
		}
	}
})
