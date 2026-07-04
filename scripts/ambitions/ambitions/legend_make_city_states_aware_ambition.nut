this.legend_make_city_states_aware_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.legend_make_city_states_aware";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "We need to catch the eye of one of the southern city states for more profitable work. They\nplay their own dangerous game, but what does it matter as long as the pay is good?";
		this.m.RewardTooltip = "You\'ll get better prices on contracts and items in city states, and earn a named handgonne.";
		this.m.UIText = "Reach \'Glorious\' renown";
		this.m.TooltipText = "Become known as \'Glorious\' (2,750 renown) in order to catch the attention of the noble houses. You can increase your renown by completing contracts and winning battles.";
		this.m.SuccessText = "[img]gfx/ui/events/event_163.png[/img]First the nobles, now the city states! The southern city states truely dwarf the wealth of the north, and are not afraid to show it. It had been a long, hard road to get their attention, but now you have you can expect much greater riches than the nobles could ever muster!";
		this.m.SuccessButtonText = "We are about to reach into the southern state\'s endless pockets!";
	}

	function onUpdateScore()
	{
		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1300)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() >= 2750 && this.World.FactionManager.isGreaterEvil())
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getBusinessReputation() >= 2750)
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		local item;
		local stash = this.World.Assets.getStash();
		item = this.new("scripts/items/weapons/named/named_handgonne");
		item = this.new("scripts/items/ammo/powder_bag");
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});

		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "You have made a powerful ally in the south"
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

