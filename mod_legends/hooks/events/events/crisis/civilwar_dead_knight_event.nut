::mods_hookExactClass("events/events/crisis/civilwar_dead_knight_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function(_screen) {
			_screen.start <- function(_event) {
				local item = ::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.faction_helm]]);
				item.setCondition(27.0);
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
			}
		});
	}

	o.onUpdateScore = function () {
		if (!this.World.FactionManager.isCivilWar())
			return;

		if (!this.World.State.getPlayer().getTile().HasRoad)
			return;

		local town = ::Legends.S.getClosestSettlement(@(_, t) !t.isSouthern() && t.isAlliedWithPlayer());
		if (town == null)
			return;

		local distance = town.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		if (distance < 4 || distance > 10)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (::Legends.Backgrounds.hasAny(bro, ::Legends.Background.Thief, ::Legends.Background.LegendCommanderAssassin) || bro.getSkills().hasTrait(::Legends.Trait.EagleEyes))
				candidates.push(bro);
		}

		if (candidates.len() != 0)
			this.m.Thief = candidates[this.Math.rand(0, candidates.len() - 1)];

		this.m.Score = 10;
	}
})
