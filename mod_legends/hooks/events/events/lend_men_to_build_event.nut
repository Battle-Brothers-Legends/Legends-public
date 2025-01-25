::mods_hookExactClass("events/events/lend_men_to_build_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options[1] = {
					Text = "Alright, I can spare a hand or few.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(1);
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}
				}
			}
			if (s.ID == "B") {
				s.Options[0].Text = "Don\'t get too used to this kind of work, mercenaries.";
				s.start <- function ( _event ) {
					this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationFavor, "You lend some help to build a mill");
					this.World.Assets.addMoney(150);
					this.List = [{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]150[/color] Crowns"
					}];
					local brothers = this.World.getPlayerRoster().getAll();
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					foreach( bro in brothers )
					{
						local id = bro.getBackground().getID();

						if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger") {
							if (this.Math.rand(1, 100) <= 33) {
								::Legends.Effects.grant(bro, ::Legends.Effect.Exhausted, function(_effect) {
									this.List.push({
										id = 10,
										icon = _effect.getIcon(),
										text = bro.getName() + " is exhausted"
									});
								}.bindenv(this));
							}

							if (this.Math.rand(1, 100) <= 50) {
								bro.improveMood(0.5, "Helped build a mill");

								if (bro.getMoodState() >= this.Const.MoodState.Neutral) {
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
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_79.png[/img]You agree to help the man. Unfortunately, it appears as though he didn\'t plan things out too well. The rooftop collapses the second one of your \'laborers\' steps foot on it, sending them through a sinkhole of shingles. Another mercenary hammers a nail into place only for the wooden support to splinter right in two, catching them in the face with shards of wood. Loose bricks find freedom, wet mud has them slipping, and all manner of workplace hazards ends the whole project in disaster.\n\n The local man apologizes profusely in between biting his nails and wondering how he\'s going to deal with the baron. Snapping his fingers, he exclaims that he\'ll just pay him the crowns.";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
			if (s.ID == "E") {
				s.start <- function ( _event ) {
					this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationFavor, "You lend some help to build a mill");
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						local id = bro.getBackground().getID();

						if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger") {
							if (this.Math.rand(1, 100) <= 33) {
								::Legends.Effects.grant(bro, ::Legends.Effect.Exhausted, function(_effect) {
									this.List.push({
										id = 10,
										icon = _effect.getIcon(),
										text = bro.getName() + " is exhausted"
									});
								}.bindenv(this));
							}

							if (this.Math.rand(1, 100) <= 33) {
								bro.worsenMood(1.0, "Helped build a mill without getting paid");

								if (bro.getMoodState() < this.Const.MoodState.Neutral) {
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
			}
		}
	}
})
