::mods_hookExactClass("ui/screens/world/world_relations_screen", function (o) {

	o.convertFactionsToUIData = function () {
		local result = {
			BusinessReputation = this.World.Assets.getBusinessReputationAsText(),
			MoralReputation = this.World.Assets.getMoralReputationAsText(),
			Factions = []
		};
		local factions = clone this.World.FactionManager.getFactions(true);
		factions.sort(this.onSortFactions);

		foreach (f in factions) {
			if (f == null || f.isHidden() || !f.isDiscovered() || f.getSettlements().len() == 0) {
				continue;
			}

			local faction = {
				ID = f.getID(),
				Name = f.getName(),
				Description = f.getDescription(),
				ImagePath = f.getUIBanner(),
				TypeImagePath = "ui/backgrounds/background_06.png",
				Motto = f.getMotto(),
				Traits = ::Const.GetFactionNobleTraitsForRelationsScreen(f),
				Relation = f.getPlayerRelationAsText(),
				RelationNum = this.Math.round(f.getPlayerRelation()),
				IsHostile = !f.isAlliedWithPlayer(),
				Characters = []
			};
			local roster = f.getRoster().getAll();

			foreach (c in roster) {
				faction.Characters.push({
					ImagePath = c.getImagePath(),
					ID = c.getID()
				});
			}

			result.Factions.push(faction);
		}

		return result;
	}
});
