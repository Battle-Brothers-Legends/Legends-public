::mods_hookExactClass("ui/screens/menu/modules/main_menu_module", function(o) {

	o.m.OnNewLegendCampaignPressedListener <- null;

	o.setOnNewLegendCampaignPressedListener <- function( _listener )
	{
		this.m.OnNewLegendCampaignPressedListener = _listener;
	}

	local clearEventListener = o.clearEventListener;
	o.clearEventListener = function()
	{
		clearEventListener();
		this.m.OnNewLegendCampaignPressedListener = null;
	}
	
	o.onNewLegendCampaignButtonPressed <- function()
	{
		if (this.m.OnNewLegendCampaignPressedListener != null)
		{
			this.m.OnNewLegendCampaignPressedListener();
		}
	}
});
