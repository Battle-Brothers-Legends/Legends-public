this.legend_allied_city_states_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.legend_allied_city_states";
		this.m.Duration = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "We shall earn the trust of a southern city state and become their ally. Surely they will\nshare the fruits of their well-stocked armories with good friends.";
		this.m.RewardTooltip = "You\'ll be awarded equipment unique to the city state with which you ally";
		this.m.UIText = "Get to \'Allied\' relations with a southern city state";
		this.m.TooltipText = "Increase the relation with any city state to \'Allied\' by fulfilling contracts given by members of the faction. Failing contracts or betraying their trust will lower your relations.";
		this.m.SuccessText = "[img]gfx/ui/events/event_163.png[/img]The southern city states truly dwarf the wealth of the north, and are not afraid to show it. It had been a long, hard road to get their attention, but now you have you can expect much greater riches from %citystate% than the nobles could ever muster!";
		this.m.SuccessButtonText = "Excellent.";
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 30)
		{
			return;
		}

		local hasFriend = false;
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.OrientalCityState)
			{
				if (f.getPlayerRelation() >= 90.0)
				{
					return;
				}
				else if (f.getPlayerRelation() >= 60.0)
				{
					hasFriend = true;
				}
			}
		}

		if (!hasFriend)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.OrientalCityState && f.getPlayerRelation() >= 90.0)
			{
				return true;
			}
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.OrientalCityState && f.getPlayerRelation() >= 90.0)
			{
				_vars.push([
					"citystate",
					f.getName()
				]);
				break;
			}
		}
	}

	function onReward()
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.OrientalCityState && f.getPlayerRelation() >= 90.0)
			{
				banner = f.getBanner();
				break;
			}
		}

		local item;
		local stash = this.World.Assets.getStash();
		item = this.new("scripts/items/weapons/named/named_handgonne");
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		item = this.new("scripts/items/ammo/special/large_powder_bag");
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}
});









//this.legend_make_city_states_aware_ambition <- this.inherit("scripts/ambitions/ambition", {
//	m = {},
//	function create()
//	{
//		this.ambition.create();
//		this.m.ID = "ambition.legend_make_city_states_aware";
//		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
//		this.m.ButtonText = "We need to catch the eye of one of the southern city states.\nThey play a dangerous game, but what does it matter as long as the pay is good?";
//		this.m.RewardTooltip = "You\'ll get better prices on contracts and items in city states, and earn a named handgonne.";
//		this.m.UIText = "Reach \'Glorious\' renown";
//		this.m.TooltipText = "Become known as \'Glorious\' (2,750 renown) in order to catch the attention of the southern city states. You can increase your renown by completing contracts and winning battles.";
//		this.m.SuccessText = "[img]gfx/ui/events/event_163.png[/img]First the nobles, now the city states! The southern city states truly dwarf the wealth of the north, and are not afraid to show it. It had been a long, hard road to get their attention, but now you have you can expect much greater riches than the nobles could ever muster!";
//		this.m.SuccessButtonText = "We are about to reach into the southern state\'s endless pockets!";

