::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_tavern_dialog_module", function(o) {

	local queryData = o.queryData; 
	o.queryData = function()
	{
		local result = queryData();
		result.RightInfo = "Pay a round for your mercenaries to get their spirits up ([img]gfx/ui/tooltips/money.png[/img]" + this.Math.round(this.World.getPlayerRoster().getSize() * 5 * this.m.Tavern.getSettlement().getBuyPriceMult()) + ").";
		
		return result;
	}
});
