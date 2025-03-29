::mods_hookExactClass("retinue/followers/agent_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.agent";
		this.m.Name = "Messenger's Rest";
		this.m.Description = "Through setting up a network of messengers, skilled agents can be employed to deliver information that you may find of use...after a short rest, of course.";
		this.m.Image = "ui/campfire/legend_agent_01";
		this.m.Cost = 2000;
		this.m.Effects = [
			"Reveals available contracts and active situations in the tooltip of settlements no matter where you are"
		];

		this.addRequirement("Have allied relations with a noble house or city state", function() {

			if (::World.Retinue.m.Slots.filter(function(i,v){if (v == null){return false} else {return v.getID() == "follower.agent"}}).len() > 0)
			{
				return true; // This requirement only needs to be met at the time of purchase; While the follower is in your retinue, this check is not needed
			}

			local factions = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
			factions.extend(::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState));

			foreach (f in factions) {
				if (f.getPlayerRelation() >= 90.0 ) {
					return true;
				}
			}

			return false;
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Eunuch, Messenger, Assassin (Southern or Northern)", [
			"background.eunuch",
			"background.messenger",
			"background.assassin",
			"background.assassin_southern",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

