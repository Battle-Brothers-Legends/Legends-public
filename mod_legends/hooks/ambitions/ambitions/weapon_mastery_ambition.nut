::mods_hookExactClass("ambitions/ambitions/weapon_mastery_ambition", function(o)
{
	o.getBrosWithMastery = function ()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local count = 0;

		foreach( bro in brothers )
		{
			local p = bro.getCurrentProperties();

			switch (true)
			{
				case p.IsSpecializedInBows:
				case p.IsSpecializedInCrossbows:
				case p.IsSpecializedInThrowing:
				case p.IsSpecializedInSlings: // legends
				case p.IsSpecializedInSwords:
				case p.IsSpecializedInCleavers:
				case p.IsSpecializedInMaces:
				case p.IsSpecializedInHammers:
				case p.IsSpecializedInAxes:
				case p.IsSpecializedInFlails:
				case p.IsSpecializedInSpears:
				case p.IsSpecializedInPolearms:
				case p.IsSpecializedInDaggers:
				case p.IsSpecializedInFists:
					count += 1;
					continue;
			}
		}

		return count;
	}
});
