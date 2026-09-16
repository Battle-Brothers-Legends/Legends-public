::mods_hookExactClass("events/events/dlc6/crisis/holywar_sand_storm_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local amount = ::Math.rand(10, 20);
					::World.Assets.addArmorParts(amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_supplies.png",
						text = "You gain [color=%positiveEvent%]+" + amount + "[/color] Tools and Supplies."
					});
					local brothers = ::World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (::Legends.Backgrounds.hasAny(bro, ::Legends.Background.Cultist, ::Legends.Background.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist))
							continue;

						if (bro.getEthnicity() == 0 && ::Math.rand(1, 100) <= 66) {
							bro.improveMood(1.0, "Approved of your decision to end the suffering of fellow northerners");

							if (bro.getMoodState() < ::Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = ::Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + ::Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						} else if (bro.getEthnicity() == 1 && ::Math.rand(1, 100) <= 66) {
							bro.worsenMood(0.75, "Disliked that you ended the suffering of northern invaders");

							if (bro.getMoodState() > ::Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = ::Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + ::Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
		}
	}
})
