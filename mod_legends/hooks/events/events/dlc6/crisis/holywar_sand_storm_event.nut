::mods_hookExactClass("events/events/dlc6/crisis/holywar_sand_storm_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local amount = this.Math.rand(10, 20);
					this.World.Assets.addArmorParts(amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_supplies.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Tools and Supplies."
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist))
							continue;

						if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66) {
							bro.improveMood(1.0, "Approved of your decision to end the suffering of fellow northerners");

							if (bro.getMoodState() < this.Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						} else if (bro.getEthnicity() == 1 && this.Math.rand(1, 100) <= 66) {
							bro.worsenMood(0.75, "Disliked that you ended the suffering of northern invaders");

							if (bro.getMoodState() > this.Const.MoodState.Neutral) {
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
})
