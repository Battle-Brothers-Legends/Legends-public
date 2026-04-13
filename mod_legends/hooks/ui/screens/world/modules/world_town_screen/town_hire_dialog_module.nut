::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_hire_dialog_module", function(o) {

	o.m.PopupDialogVisible <- false;

	local onHireRosterEntry = o.onHireRosterEntry;
	o.onHireRosterEntry = function ( _entityID )
	{
		local original = ::World.Assets.m.HiringCostMult;
		if (::World.Retinue.hasFollower("follower.recruiter"))
			::World.Assets.m.HiringCostMult *= 0.9;
		local ret = onHireRosterEntry(_entityID);
		::World.Assets.m.HiringCostMult = original;
		return ret;
	}

	o.onDismissRosterEntry <- function ( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = this.World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = this.World.Assets.getMoney();
			local tryoutCost = entry.getTryoutCost();

			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
			{
				if (currentMoney < tryoutCost)
				{
					return {
						Result = this.Const.UI.Error.NotEnoughMoney,
						Assets = null
					};
				}
			}

			this.World.getRoster(this.m.RosterID).remove(entry);

			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
			{
			 this.World.Assets.addMoney(-tryoutCost);
			}

			if (this.World.getRoster(this.m.RosterID).getSize() == 0)
			{
				this.m.Parent.getMainDialogModule().reload();
			}

			return {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = this.Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	if ("isAnimating" in o)
	{
		local isAnimating = o.isAnimating;
		o.isAnimating = function ()
		{
			return isAnimating() || this.m.PopupDialogVisible;
		}
	}
	else
	{
		o.isAnimating <- function ()
		{
			return this.ui_module.isAnimating() || this.m.PopupDialogVisible;
		}
	}
	
	if ("onModuleShown" in o)
	{
		local onModuleShown = o.onModuleShown;
		o.onModuleShown = function()
		{
			onModuleShown();
			this.m.PopupDialogVisible = false;
		}
	}
	else
	{
		o.onModuleShown <- function()
		{
			this.ui_module.onModuleShown();
			this.m.PopupDialogVisible = false;
		}
	}
	
	if ("onModuleHidden" in o)
	{
		local onModuleHidden = o.onModuleHidden;
		o.onModuleHidden = function()
		{
			onModuleHidden();
			this.m.PopupDialogVisible = false;
		}
	}
	else
	{
		o.onModuleHidden <- function()
		{
			this.ui_module.onModuleHidden();
			this.m.PopupDialogVisible = false;
		}
	}

	o.onPopupDialogIsVisible <- function ( _isVisible )
	{
		this.m.PopupDialogVisible = _isVisible;
	}

	o.onKnownPerksIconClicked <- function ()
	{
		if (this.m.JSHandle == null || !this.isVisible()) return;

		// this.Tooltip.hide();
		// local bro = this.Tactical.getEntityByID(_id);
		// local entity = this.UIDataHelper.convertEntityToUIData(bro, null);
		this.m.JSHandle.asyncCall("showKnownPerksPopupDialog", null);
	}
});
