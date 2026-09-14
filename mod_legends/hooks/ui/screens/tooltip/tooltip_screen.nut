::mods_hookExactClass("ui/screens/tooltip/tooltip_screen", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Tooltip.setOnQueryUIProfessionTooltipDataListener(this.m.TooltipEvents.onQueryUIProfessionTooltipData);
	}
});
