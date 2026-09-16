::mods_hookExactClass("events/events/cultist_finale_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Sacrifice.getImagePath());
					local dead = _event.m.Sacrifice;
					::Legends.addFallen(dead, "Sacrificed to Davkul");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Sacrifice.getName() + " has died"
					});
					this.List.push(::Legends.EventList.changeMoralReputation(-10));
					_event.m.Sacrifice.getItems().transferToStash(::World.Assets.getStash());
					_event.m.Sacrifice.getSkills().onDeath(::Const.FatalityType.None);
					::World.getPlayerRoster().remove(_event.m.Sacrifice);
					::World.Assets.getStash().makeEmptySlots(1);
					local item = this.new("scripts/items/legend_armor/legendary/legend_davkul_armor");
					item.m.Description = "A grisly aspect of Davkul, an ancient power not from this world, and the last remnants of " + _event.m.Sacrifice.getName() + " from whose body it has been fashioned. It shall never break, but instead keep regrowing its scarred skin on the spot.";
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain the " + item.getName()
					});
					local brothers = ::World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist))
						{
							bro.improveMood(2.0, "Appeased Davkul");

							if (bro.getMoodState() >= ::Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = ::Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + ::Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
						else
						{
							bro.worsenMood(3.0, "Horrified by the death of " + _event.m.Sacrifice.getName());

							if (bro.getMoodState() < ::Const.MoodState.Neutral)
							{
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
			if (s.ID == "D") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					local brothers = ::World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist)) {
							bro.worsenMood(2.0, "Was denied the chance to appease Davkul");
							if (bro.getMoodState() < ::Const.MoodState.Neutral) {
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
			if (s.ID == "") {

			}
			if (s.ID == "") {

			}
		}
	}

	o.onUpdateScore = function ()
	{
		if (::World.getTime().IsDaytime)
			return;

		if (::World.getTime().Days <= 200)
			return;

		if (::World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
			return;

		if (!::World.Assets.getStash().hasEmptySlot())
			return;

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist)) {
				cultist_candidates.push(bro);
				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && ::Legends.Backgrounds.has(bro, ::Legends.Background.Cultist))
					bestCultist = bro;
			}
			else if (bro.getLevel() >= 12 && !bro.getSkills().hasTrait(::Legends.Trait.Player) && !bro.getFlags().get("IsPlayerCharacter"))
				sacrifice_candidates.push(bro);
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 12 || sacrifice_candidates.len() == 0)
			return;

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[::Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = 3;
	}
})
