::mods_hookDescendants("contracts/contract", function (o) {
	local onClear = o.onClear;
	o.onClear = function ()
	{
		if (this.isActive())
		{
			local contract_faction = this.World.FactionManager.getFaction(this.getFaction());
			local towns = contract_faction.getSettlements();

			foreach( town in towns )
			{
				town.getSprite("selection").Visible = false;
			}
		}

		onClear();
	};
});
