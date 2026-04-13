::mods_hookExactClass("ambitions/ambitions/ranged_mastery_ambition", function(o) 
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.ButtonText = "The company lacks competent archers, limiting our tactical options.\nWe shall train three men to master bow, crossbow or sling and be deadly from afar!";
		this.m.UIText = "Have 3 men with the bow, sling, or crossbow mastery perk";
	}

	o.getBrosWithMastery = function ()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local count = 0;

		foreach( bro in brothers )
		{
			local p = bro.getCurrentProperties();

			if (p.IsSpecializedInBows || p.IsSpecializedInCrossbows || p.IsSpecializedInSlings)
			{
				count = ++count;
			}
		}

		return count;
	}
});
