::FU.Class.TooltipsModAddon <- class extends ::FU.Class.SystemModAddon
{
	function setTooltips( _tooltipTable )
	{
		::FU.System.Tooltips.setTooltips(this.Mod.getID(), _tooltipTable);
	}

	function getTooltip( _identifier )
	{
		return ::FU.System.Tooltips.getTooltip(this.Mod.getID(), _identifier);
	}
}
