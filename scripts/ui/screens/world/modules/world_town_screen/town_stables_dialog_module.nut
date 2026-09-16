this.town_stables_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		RosterID = 0
	},
	function setRosterID( _id )
	{
		this.m.RosterID = _id;
	}

	function create()
	{
		this.m.ID = "StablesDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function clear()
	{
		this.m.RosterID = 0;
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function queryHireInformation()
	{
		return {
			Roster = this.UIDataHelper.convertStablesRosterToUIData(this.m.RosterID),
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onHireRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = ::World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = ::World.Assets.getMoney();
			local currentFood = ::World.Assets.getFood();
			local currentBrothers = entities.len();
			local brothersMax = ::World.Assets.getBrothersMax();
			local hiringCost = entry.getHiringCost();
			if (currentMoney < hiringCost)
			{
				return {
					Result = ::Const.UI.Error.NotEnoughMoney,
					Assets = null
				};
			}

			if (currentBrothers + 1 > brothersMax)
			{
				return {
					Result = ::Const.UI.Error.NotEnoughRosterSpace,
					Assets = null
				};
			}
			::World.getPlayerRoster().add(entry);
			::World.getRoster(this.m.RosterID).remove(entry);
			entry.onHired();
			::World.Assets.addMoney(-hiringCost);

			if (::World.getRoster(this.m.RosterID).getSize() == 0)
			{
				this.m.Parent.getMainDialogModule().reload();
			}

			return {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = ::Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function onTryoutRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = ::World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = ::World.Assets.getMoney();
			local tryoutCost = entry.getTryoutCost();

			if (currentMoney < tryoutCost)
			{
				return {
					Result = ::Const.UI.Error.NotEnoughMoney,
					Assets = null
				};
			}

			entry.setTryoutDone(true);
			::World.Assets.addMoney(-tryoutCost);
			return {
				Result = 0,
				Roster = this.UIDataHelper.convertStablesRosterToUIData(this.m.RosterID),
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = ::Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function onDismissRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = ::World.getPlayerRoster();
			local entities = roster.getAll();

			::World.getRoster(this.m.RosterID).remove(entry);

			if (::World.getRoster(this.m.RosterID).getSize() == 0)
			{
				this.m.Parent.getMainDialogModule().reload();
			}

			return {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = ::Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function findEntityWithinRoster( _entryID )
	{
		local roster = ::World.getRoster(this.m.RosterID);
		local entities = roster.getAll();

		if (entities == null)
		{
			return null;
		}

		foreach( entity in entities )
		{
			if (entity.getID() == _entryID)
			{
				return entity;
			}
		}

		return null;
	}

});

