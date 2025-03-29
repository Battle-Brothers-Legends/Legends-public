::mods_hookExactClass("contracts/contracts/defend_settlement_bandits_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Judging by the fire-gutted outskirts, %s has a serious raider problem. You may just be the cure.",
			"With each passing day, the town's serious brigand problem threatens to worsen, unless action is taken.",
			"At night brigands roam freely, posing a serious threat to the safety and security of the town.",
			"In %s, the makeshift barricades and fire-gutted buildings hint how dangerous the local brigands have become.",
			"Sellswords are being sought in %s to repel a ruthless band of brigands terrorising the town.",
			"Desperation mounts as the town faces a ruthless brigand gang, with no end in sight.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = "Defend Settlement";
			}
		}
	}

	o.onIsValid = function ()
	{
		local nearestBandits = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getSettlements());
		local nearestZombies = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());

		if ((nearestZombies == null || nearestZombies.getTile().getDistanceTo(this.m.Home.getTile()) > 20) && (nearestBandits == null || nearestBandits.getTile().getDistanceTo(this.m.Home.getTile()) > 20))
		{
			return false;
		}

		local locations = this.m.Home.getAttachedLocations();

		foreach( l in locations )
		{
			if (l.isUsable() && l.isActive() && !l.isMilitary())
			{
				return true;
			}
		}

		return false;
	}
});
