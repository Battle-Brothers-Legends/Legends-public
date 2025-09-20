::mods_hookNewObjectOnce("ui/screens/menu/main_menu_screen", function(o)
{
	o.showMainMenuModule <- function()
	{
		this.m.JSHandle.asyncCall("showMainMenuModule", null);
	}

	o.hideMainMenuModule <- function()
	{
		this.m.JSHandle.asyncCall("hideMainMenuModule", null);
	}

	o.hideNewCampaignModule <- function()
	{
		this.m.JSHandle.asyncCall("hideNewCampaignModule", null);
	}

	o.showNewCampaignModule <- function()
	{
		this.m.JSHandle.asyncCall("showNewCampaignModule", null);
	}

});
