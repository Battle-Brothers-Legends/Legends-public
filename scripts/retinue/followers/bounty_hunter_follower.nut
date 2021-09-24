this.bounty_hunter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
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
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			},
			{
				IsSatisfied = false,
				Text = "Have at least one of the following backgrounds: Manhunter, Witch Hunter, Beast Slayer"
			}
		];
		this.m.RequiredSkills = [
			"background.witchhunter",
			"background.beast_slayer",
			"background.manhunter"
		]
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onUpdate()
	{
		if ("ChampionChanceAdditional" in this.World.Assets.m)
			this.World.Assets.m.ChampionChanceAdditional = 3;
	}

	function onEvaluate()
	{
		local namedItems = this.getNumberOfNamedItems();

		this.m.Requirements[0].Text = "Have " + this.Math.min(1, namedItems) + "/1 named or legendary items in your possession ";
		if (namedItems >= 1) 
		{
			this.m.Requirements[0].IsSatisfied = true;
		} 

		this.follower.onEvaluate();
	}

	function onChampionKilled( _champion )
	{
		if (this.Tactical.State.getStrategicProperties() == null || !this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			this.World.Assets.addMoney(this.Math.floor(_champion.getXPValue()));
		}
	}

	function getNumberOfNamedItems()
	{
		local n = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (item != null && item != "-1" && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
				{
					n = ++n;
				}
			}
		}

		return n;
	}

});

