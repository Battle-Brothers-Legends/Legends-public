::mods_hookExactClass("events/events/crisis/civilwar_dead_knight_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					local item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.faction_helm]]);
					item.setCondition(27.0);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.FactionManager.isCivilWar())
			return;

		if (!this.World.State.getPlayer().getTile().HasRoad)
			return;

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearTown = false;

		foreach( t in towns ) {
			if (t.isSouthern())
				continue;

			if (t.getTile().getDistanceTo(playerTile) <= 10 && t.getTile().getDistanceTo(playerTile) >= 4 && t.isAlliedWithPlayer()) {
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.legend_commander_assassin" || bro.getSkills().hasTrait(::Legends.Trait.EagleEyes))
				candidates.push(bro);
		}

		if (candidates.len() != 0)
			this.m.Thief = candidates[this.Math.rand(0, candidates.len() - 1)];

		this.m.Score = 10;
	}
})
