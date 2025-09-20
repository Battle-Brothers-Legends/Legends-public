::mods_hookNewObject("ui/screens/tooltip/modules/tooltip", function(o){
	o.onQueryFUTooltipData <- function(_data)
	{
		return ::TooltipScreen.m.TooltipEvents.onQueryFUTooltipData(_data);
	}
})
