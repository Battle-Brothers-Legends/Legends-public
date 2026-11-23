::mods_hookExactClass("events/events/giant_tree_in_forest_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_25.png[/img]You pass through a wall of shrubs and find yourself stopped by quite a sight. To call it a tree would seem insulting. The trees about it are so low beneath their neighbor they appear to be bending at midtrunk, swearing fealty to that which is arboreally suzerain, a domain rippled with roots as thick as any man, and enough shade above to lose time between the days and night.\n\n You walk to the base of the enormity and run a hand along its bark, but then you stop, fearing that your flesh may have just trespassed upon holy ground like a child tumbling playfully into a church of one wholly quiet crowd. %monk% the monk comes to your side nodding and with %their_monk% hands firmly behind %their_monk% back.%SPEECH_ON%This is a godtree. The roots go through the earth and into the realm of the gods. It is said they once listened, but now... we are not so sure.%SPEECH_OFF%You stare at the %person_monk%, and %their_monk% particularly withheld posture, and ask if %they_monk% fears the tree. %They_monk% smiles at you and shakes %their_monk% head.%SPEECH_ON%I respect it like a man would the sea, for the waters of the oceans hold many things to fear and, yet, the sailor sails anyway. Were the ocean a docile beast, would man refer to it so lovingly?%SPEECH_OFF%";
			_screen.start <- function (_event) {
				_event.m.Monk.improveMood(2.0, "Saw a godtree with their own eyes");
				if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}
			}
		});
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime) {
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest	&& currentTile.Type != this.Const.World.TerrainType.LeaveForest) {
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach (t in towns) if (t.getTile().getDistanceTo(playerTile) <= 6) {
			return false;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local monk_candidates = [];

		foreach (bro in brothers) if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant" || bro.getBackground().getID() == "background.legend_herbalist" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_commander_ranger" || bro.getBackground().getID() == "background.legend_vala") {
			monk_candidates.push(bro);
		}

		if (monk_candidates.len() == 0) {
			return;
		}

		this.m.Monk = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		this.m.Score = 10;
	}
})
