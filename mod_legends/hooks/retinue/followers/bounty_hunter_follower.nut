::mods_hookExactClass("retinue/followers/bounty_hunter_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.bounty_hunter";
		this.m.Name = "Bounty Board";
		this.m.Description = "A well maintained bounty board can keep everyone up to date on which heads they should be taking after a battle.";
		this.m.Image = "ui/campfire/legend_bounty_hunter_01";
		this.m.Cost = 4000;
		this.m.Effects = [
			"Significantly increases the chance of encountering champions",
			"Pays between 300 and 750 crowns for every champion slain"
		];

		this.addRequirement("Have at least a named or a legendary items in your possession ", function() {
			return this.getNumberOfNamedItems() >= 1;
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Manhunter, Witch Hunter, Beast Slayer, Bounty Hunter", [
			"background.witchhunter",
			"background.beast_slayer",
			"background.manhunter",
			"background.legend_companion_melee",
			"background.legend_companion_ranged",
			"background.legend_bounty_hunter"
		]);
	}

	o.onUpdate = function()
	{
		if ("ChampionChanceAdditional" in this.World.Assets.m)
			this.World.Assets.m.ChampionChanceAdditional = this.World.Assets.getOrigin().getID() == "scenario.legends_party" ? 8 : 3;
	}

	o.onChampionKilled = function( _champion )
	{
		if (this.Tactical.State.getStrategicProperties() == null || !this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			this.World.Assets.addMoney(this.Math.floor(_champion.getXPValue()));
		}
	}

	o.getNumberOfNamedItems = function()
	{
		local n = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isNamed())
				++n;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			foreach( item in bro.getItems().getAllItems())
			{
				if (item.isNamed())
					++n;
			}
		}

		return n;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

