::mods_hookExactClass("events/events/bastard_assassin_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Options = [{
					Text = "Take care you bastard.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Assassin);
						this.World.getTemporaryRoster().clear();
						_event.m.Assassin.onHired();
						_event.m.Bastard.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.Bastard.getSkills().onDeath(this.Const.FatalityType.None);
						::Legends.addFallen(_event.m.Bastard, "Left to claim their birthright");
						this.World.getPlayerRoster().remove(_event.m.Bastard);
						_event.m.Bastard = null;
						return 0;
					}
				}]
			}
			if (s.ID == "Decline3") {
				s.start <- function( _event ) {
					this.Characters.push(_event.m.Bastard.getImagePath());

					if (!_event.m.Bastard.getSkills().hasTrait(::Legends.Trait.Loyal) && !_event.m.Bastard.getSkills().hasTrait(::Legends.Trait.Disloyal)) {
						::Legends.Traits.grant(_event.m.Bastard, ::Legends.Trait.Loyal, function(_trait) {
							this.List.push({
								id = 10,
								icon = _trait.getIcon(),
								text = _event.m.Bastard.getName() + " is now loyal"
							});
						}.bindenv(this));
					}
					this.World.Assets.addMoralReputation(2);
					_event.m.Bastard.improveMood(2.0, "You risked your life for him");
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});

					if (_event.m.Bastard.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Bastard.getMoodState()],
							text = _event.m.Bastard.getName() + this.Const.MoodStateEvent[_event.m.Bastard.getMoodState()]
						});
					}

					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Bastard.getID())
							continue;

						if (this.Math.rand(1, 100) <= 50) {
							bro.improveMood(0.5, "You risked your life for the men");

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
	}

	o.onUpdateScore = function () {
		if (this.World.getTime().IsDaytime)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local candidates = [];
		local candidates_other = [];
		local cantidates_assassins = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.bastard")
				candidates.push(bro);
			else if (bro.getBackground().getID() == "background.assassin" || bro.getBackground().getID() == "background.legend_commander_assassin")
				cantidates_assassins.push(bro);
			else if (!bro.getSkills().hasTrait(::Legends.Trait.Player))
				candidates_other.push(bro);
		}

		if (candidates.len() == 0 || candidates_other.len() == 0 || cantidates_assassins.len() >= 1)
			return;

		this.m.Bastard = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}
})
