this.scout_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Radius = 250,
		Rate = 0,
		Results = [],
		NumBros = 0,
		ActivityName = "Scouting"
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Scout;
		this.m.ModName = "Scout";
		this.m.ModMod = 10.0;
		this.m.BaseCraft = 0.1;
		this.m.Slot = "scout";
		this.m.Name = "Patrol Station";
		this.m.Description = "Send out a patrol to keep an eye on the surrounding terrain";
		this.m.BannerImage = "ui/buttons/banner_scout.png";
		this.m.CanEnter = false;
		this.m.RequiresHealthyBros = true;
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		//desc += "The Patrol station can be upgraded by purchasing a patrol cart from a settlement merchant. An upgraded tent has a 15% increase in patrol speed and ";
		//desc += "has a chance of revealing the defenders of any camps encountered. ";
		//desc += "Additionally, while on patrol there's a chance that the location of enemy outposts can be determined."; remember reduces chance of getting hurt
		return "Assign men to scout around and reveal information about the surroundings.";
	}

	function getModifierTooltip()
	{
		local mod = this.getModifiers();
		local ret = [{
			id = 6,
			type = "text",
			icon = "ui/buttons/asset_vision_up.png",
			text = "Total patrol modifier is [color=%positive%]" + mod.Craft * 100.0 + "%[/color]."
		}];
		local id = 7;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] * 100.0 + "%[/color] " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Scout);
	}

	function getLevel()	{
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function getVisionRadius() {
		return this.m.Radius;
	}

	function init()	{
		this.m.Radius = 250;
		local mod = this.getModifiers();
		this.m.Rate = mod.Craft;
		this.m.Results = [];
		this.m.NumBros = mod.Assigned;
	}

	function getModifiers() {
		local ret =	{
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		local self = this;
		local scoutingBros = ::World.getPlayerRoster().getAll().filter(@(_, _bro) (_bro.getCampAssignment() == self.m.ID && !self.isRecovering(_bro)));
		foreach (bro in scoutingBros) {
			ret.Assigned++;
			ret.Modifiers.push([this.m.BaseCraft * (1 + bro.getBackground().getModifiers().Scout) * (bro.getSkills().hasPerk(::Legends.Perk.LegendLookout) ? 1.1 : 1.0), bro.getName(), bro.getBackground().getNameOnly()]);
		}

		ret.Modifiers.sort(this.sortModifiers);
		foreach (i, mod in ret.Modifiers) {
			mod[0] *= ::Math.pow(i + 1, -0.5) * (this.getUpgraded() ? 1.15 : 1);
			ret.Craft += mod[0];
		}
		return ret;
	}

	function getResults() {
		local res = [];
		local id = 110;
		foreach (b in this.m.Results) {
			res.push({
				id = id++,
				icon = b.Icon,
				text = b.Text
			});
		}
		return res;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}

	function completed() {
		local mod = this.getModifiers();
		if (mod.Assigned == 0) {
			return;
		}
		// local r = this.Math.min(75, 10 * this.Math.pow(this.m.Camp.getCampTimeHours(), mod.Craft/2));

		// if (this.Math.rand(1, 100) > r)
		// {
		//	 return;
		// }

		local campHours = this.m.Camp.getCampTimeHours();
		local self = this;
		local assignedBros = ::World.getPlayerRoster.getAll().filter(@(_,_bro) (_bro.getCampAssignment() == self.m.ID && !self.isRecovering(_bro)));
		foreach(bro in assignedBros) {
			this.addNegativeSideEffects(bro, campHours);
		}

		local playerTile = ::World.State.getPlayer().getTile();
		local locations = [];
		local scoutableLocations = ::World.EntityManager.getLocations().filter(@(_, _location) !_location.isAlliedWithPlayer());
		foreach(location in scoutableLocations)	{
			if (!location.isShowingDefenders() && location.m.IsSpawningDefenders && location.getDefenderCount() > 0 && campHours > 3) {
				if (location.isVisibleToEntity(::World.State.getPlayer(), this.m.Radius)) {
					this.m.Results.push({
						Icon = "ui/icons/vision.png",
						Text = "While on patrol, " + mod.Modifiers[::Math.rand(0, mod.Modifiers.len() - 1)][1] + " discovered " + location.getName() + " has " + location.getDefenderCount() + " defenders."
					});
				}
				location.m.IsShowingDefenders = true;
			}

			if (location.isDiscovered() || location.getTile().getDistanceTo(playerTile) - ::Math.rand(1, 10) > 20 * (1 + this.getModifiers().Craft)) {
                continue;
            }
			locations.push(location);
		}
	
		if(this.getUpgraded()) {
			for(local i = 0; i < ::Legends.S.randomizeFractionToInt(campHours * 0.1 + (0.1 * this.getModifiers().Craft)) ; i++) {
				if (locations.len() == 0) {
        			break; 
    			}
				
				local randomLocationIndex = ::Math.rand(0, locations.len() - 1);
				local location = locations[randomLocationIndex];
				locations.remove(randomLocationIndex);
				location.setDiscovered(true);
				::World.uncoverFogOfWar(location.getTile().Pos, 400.0);

				local tracks = "";
				switch (::World.FactionManager.getFaction(location.getFaction()).getType()) {
					case ::Const.FactionType.Orcs:
						tracks = "Orc";
						break;
					case ::Const.FactionType.Goblins:
						tracks = "Goblin";
						break;
					case ::Const.FactionType.Undead:
					case ::Const.FactionType.Zombies:
						tracks = "Undead";
						break;
					default:
						tracks = "Human";
						break;
				}

				if (location != null) {
					this.m.Results.push({
						Icon = "ui/icons/vision.png",
						Text = "While on patrol, " + mod.Modifiers[::Math.rand(0, mod.Modifiers.len() - 1)][1] + " came across some " + tracks + " tracks and followed them towards the " + location.getName() + ". It is " + (::Const.Strings.Distance[::Math.min(::Const.Strings.Distance.len() - 1, playerTile.getDistanceTo(location.getTile()) / 30.0 * (::Const.Strings.Distance.len() - 1))]) + " to the " + ::Const.Strings.Direction8[playerTile.getDirection8To(location.getTile())] + "."
					});
				}
			}
		}
	}

	function getUpdateText() {
		return this.m.NumBros == 0 ? "No one on patrol!" : ("Patrol radius ... " + this.m.Radius);
	}

	function updateTick ( _hours ) {
		this.m.Radius = 250 + ::Math.pow(this.m.Rate, 0.5) * 300.0 * ::Math.pow(_hours, 0.5 - (0.1 * this.m.Rate));
	}
});
