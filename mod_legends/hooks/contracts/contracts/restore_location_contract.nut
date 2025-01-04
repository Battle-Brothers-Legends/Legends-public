::mods_hookExactClass("contracts/contracts/restore_location_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"The townsfolk of %s are looking to rebuild the %s, ideally with some heartless sellswords to deal with any trouble.",
			"%s seeks to reclaim the %s. Mercenary assistance will be needed to secure the site.",
			"Help %s expel vagrants and thieves from the %s, so the area can be rebuilt.",
			"Rebuilding efforts in %s are ready to get underway, there is just the matter of site security to attend to first.",
			"%s wishes to rebuild the fire-gutted ruins of the %s. First the area must be made safe.",
			"Squatters, thieves and all kinds of miscreants love to lurk in ruins. Drive them out so %s can rebuild.",
			"With the danger now passed, it is time for %s to reclaim and rebuild the %s.",
			"The nobility of %s will not tolerate such unsightly ruins on the city outskirts. Help reclaim the %s.",
		];
	}

	// Ran when we actually add the contract
	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);
		local count = 0, find = r.find("%");

		while(find != null)
		{
			find = r.find("%", find + 1);
			++count;
		}

		switch (count)
		{
		case 2:
			r = format(r,
				::Const.UI.getColorized(this.m.Location.getSettlement().getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()),
				::Const.UI.getColorized(this.m.Location.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue())
			);
			break;

		case 1:
			r = format(r, ::Const.UI.getColorized(::World.FactionManager.getFaction(this.getFaction()).getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
			break;
		}

		this.m.Description = r;
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Escort")
			{
				local start = s.start;
				s.start <- function()
				{
					start();
					if (!this.World.State.isPaused())
					{
						this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
					}

					this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;
				}
				s.update <- function ()
				{
					if (this.Contract.m.Caravan == null || this.Contract.m.Caravan.isNull() || !this.Contract.m.Caravan.isAlive() || this.Contract.m.Caravan.getTroops().len() == 0)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
						return;
					}

					if (!this.Contract.m.IsEscortUpdated)
					{
						this.World.State.setEscortedEntity(this.Contract.m.Caravan);
						this.Contract.m.IsEscortUpdated = true;
					}

					this.World.State.setCampingAllowed(false);
					this.World.State.getPlayer().setPos(this.Contract.m.Caravan.getPos());
					this.World.State.getPlayer().setVisible(false);
					this.World.Assets.setUseProvisions(false);
					this.World.getCamera().moveTo(this.World.State.getPlayer());

					// from vanilla
					// if (!this.World.State.isPaused())
					// {
					// 	this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
					// }

					// this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;

					if (this.Flags.get("IsFleeing"))
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
						return;
					}
					else if (this.Contract.isPlayerAt(this.Contract.m.Location))
					{
						this.Contract.setScreen("RebuildingLocation");
						this.World.Contracts.showActiveContract();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "Refugees2")
			{
				foreach (option in s.Options)
				{
					option.Text = "Get lost, you rabble! (Decrease Moral Reputation)";
				}
			}
			if (s.ID == "Refugees3")
			{
				foreach (option in s.Options)
				{
					option.Text = "We\'ll find work elsewhere... (Decrease Moral Reputation)";
				}
			}
		}
	}
});
