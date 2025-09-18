::mods_hookExactClass("events/events/cultist_finale_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-10);
					this.Characters.push(_event.m.Sacrifice.getImagePath());
					local dead = _event.m.Sacrifice;
					::Legends.addFallen(dead, "Sacrificed to Davkul");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Sacrifice.getName() + " has died"
					});
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases greatly"
					});
					_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Sacrifice.getSkills().onDeath(this.Const.FatalityType.None);
					this.World.getPlayerRoster().remove(_event.m.Sacrifice);
					this.World.Assets.getStash().makeEmptySlots(1);
					local item = this.new("scripts/items/legend_armor/legendary/legend_davkul_armor");
					item.m.Description = "A grisly aspect of Davkul, an ancient power not from this world, and the last remnants of " + _event.m.Sacrifice.getName() + " from whose body it has been fashioned. It shall never break, but instead keep regrowing its scarred skin on the spot.";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain the " + item.getName()
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
						{
							bro.improveMood(2.0, "Appeased Davkul");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
						else
						{
							bro.worsenMood(3.0, "Horrified by the death of " + _event.m.Sacrifice.getName());

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
			if (s.ID == "D") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
							bro.worsenMood(2.0, "Was denied the chance to appease Davkul");
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
			if (s.ID == "") {

			}
			if (s.ID == "") {

			}
		}
	}

	o.onUpdateScore = function ()
	{
		if (this.World.getTime().IsDaytime)
			return;

		if (this.World.getTime().Days <= 200)
			return;

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
				cultist_candidates.push(bro);
				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && bro.getBackground().getID() == "background.cultist")
					bestCultist = bro;
			}
			else if (bro.getLevel() >= 12 && !bro.getSkills().hasTrait(::Legends.Trait.Player) && !bro.getFlags().get("IsPlayerCharacter"))
				sacrifice_candidates.push(bro);
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 12 || sacrifice_candidates.len() == 0)
			return;

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = 3;
	}
})
