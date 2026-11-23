this.scout_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Radius = 250,
		Rate = 0,
		Results = [],
		NumBros = 0
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Scout;
		this.m.ModName = "Scout";
		this.m.ModMod = 10.0;
		this.m.BaseCraft = 0.1;
		this.m.Slot = "scout";
		this.m.Name = "Patrol Station";
		this.m.Description = "Send out a patrol to keep an eye on the surrounding terrain";
		this.m.BannerImage = "ui/buttons/banner_scout.png";
		this.m.CanEnter = false;
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*"
		}
		return this.m.Name +  " *Not Upgraded*"
	}

	function getDescription()
	{
		local desc = "";
		desc += "Getting ambushed while camping is the surest way to ruin a good nights sleep. ";
		desc += "Make sure someone is on patrol in order to have eyes and ears and the local landscape. ";
		desc += "The more men assigned on patrol, the faster and further your visibility grows.";
		desc += "\n\n";
		desc += "The Patrol station can be upgraded by purchasing a patrol cart from a settlement merchant. An upgraded tent has a 15% increase in patrol speed and ";
		desc += "has a chance of revealing the defenders of any camps encountered. ";
		desc += "Additionally, while on patrol there's a chance that the location of enemy outposts can be determined.";
		desc += "\n\n";
		desc += "Assigned scouts with the Lookout perk will pause time when an enemy is sighted";
		return desc;
	}

	function getModifierToolip()
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

	function isHidden()
	{

		if (::Legends.Settings.skipCamp())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampScouting")
	}

	function getUpgraded()
	{
		return this.Stash.hasItem(::Legends.Camp.Tent.Scout);
	}

	function getLevel()
	{
		local pro = "dude";
		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";

		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function getVisionRadius()
	{
		return this.m.Radius;
	}

	function init()
	{
		this.m.Radius = 250;
		local mod = this.getModifiers();
		this.m.Rate = mod.Craft;
		this.m.Results = [];
		this.m.NumBros = mod.Assigned;
	}

	function getModifiers()
	{
		local ret =
		{
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
				continue;
			local mod = this.m.BaseCraft + this.m.BaseCraft * bro.getBackground().getModifiers().Scout;

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendLookout))
				mod = mod * 1.1;

			++ret.Assigned;
			ret.Modifiers.push([mod, bro.getName(), bro.getBackground().getNameOnly()]);
		}

		ret.Modifiers.sort(this.sortModifiers);
		for (local i = 0; i < ret.Modifiers.len(); i = ++i)
		{
			ret.Modifiers[i][0] = ret.Modifiers[i][0] * this.Math.pow(i + 1, -0.5);
			if (this.getUpgraded())
			{
				ret.Modifiers[i][0] *= 1.15;
			}
			ret.Craft += ret.Modifiers[i][0];
		}
		return ret;
	}

	function getResults()
	{
		local res = [];
		local id = 110;
		foreach (b in this.m.Results)
		{
			res.push({
		 		id = id++,
		 		icon = b.Icon,
		 		text = b.Text
			})
		}
		return res;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function completed()
	{
		local mod = this.getModifiers();
		if (mod.Assigned == 0)
		{
			return;
		}

		if (!this.getUpgraded())
		{
			return
		}

		// local r = this.Math.min(75, 10 * this.Math.pow(this.m.Camp.getCampTimeHours(), mod.Craft/2));

		// if (this.Math.rand(1, 100) > r)
		// {
		//	 return;
		// }

		local bro = mod.Modifiers[this.Math.rand(0, mod.Modifiers.len() - 1)][1];

		local locations = [];
		foreach( s in this.World.EntityManager.getLocations() )
		{
			if (s.isAlliedWithPlayer())
			{
				continue;
			}

			//If within patrol radius, give chance to discover defenders
			if (!s.isShowingDefenders() && s.m.IsSpawningDefenders && s.getDefenderCount() > 0 && this.m.Camp.getCampTimeHours() > 3)
			{
				if (s.isVisibleToEntity(this.World.State.getPlayer(), this.m.Radius))
				{
					this.m.Results.push({
						Icon = "ui/icons/vision.png",
						Text = "While on patrol, " + bro + " discovered " + s.getName() + " has " + s.getDefenderCount() + " defenders."
					});
				}
				s.m.IsShowingDefenders = true;
			}


			if (s.getLoot().isEmpty())
			{
				continue;
			}

			local d = s.getTile().getDistanceTo(this.World.State.getPlayer().getTile());
			if (d - this.Math.rand(1, 10) > 20)
			{
				continue;
			}

			locations.push(s);
		}

		if (locations.len() == 0)
		{
			return;
		}

		local location = locations[this.Math.rand(0, locations.len() - 1)];
		local f = this.World.FactionManager.getFaction(location.getFaction());
		local tracks = "";
		if (f.getType() == this.Const.FactionType.Orcs)
		{
			tracks = "Orc"
		}
		else if (f.getType() == this.Const.FactionType.Goblins)
		{
			tracks = "Goblin"
		}
		else if (f.getType() == this.Const.FactionType.Undead)
		{
			tracks = "Undead"
		}
		else
		{
			tracks = "Human"
		}

		local distance = location != null  ? this.World.State.getPlayer().getTile().getDistanceTo(location.getTile()) : 0;
		distance = this.Const.Strings.Distance[this.Math.min(this.Const.Strings.Distance.len() - 1, distance / 30.0 * (this.Const.Strings.Distance.len() - 1))];
		local direction = location != null ? this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(location.getTile())] : "";

		this.m.Results.push({
			Icon = "ui/icons/vision.png",
			Text = "While on patrol, " + bro + " came across some " + tracks + " tracks. The tracks lead off towards the " + direction + ". The age of the tracks indicate that the group must be " + distance + "."
		});

	}

	function getUpdateText()
	{
		if (this.m.NumBros == 0)
		{
			return "No one on patrol!";
		}

		return "Patrol radius ... " + this.m.Radius;
	}

	function updateTick ( _hours )
	{
		this.m.Radius = 250 + this.Math.pow(this.m.Rate, 0.5) * 300.0 * this.Math.pow(_hours, 0.5 - (0.1 * this.m.Rate));
	}

	function onClicked( _campScreen )
	{
		_campScreen.showScoutDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}

});
