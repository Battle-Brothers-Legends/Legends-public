::mods_hookExactClass("contracts/contracts/intercept_raiding_parties_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Southern Raids";
		this.m.DescriptionTemplates = [
			"Southern raiders are coming to burn the homes, shops and farms in lands belonging to %s. Times are grim.",
			"Tension hangs heavy in the air, as folk are expecting troops from the South to descend upon %s any day now.",
			"Due to spectacular mismanagement, the nobles have no troops to spare to defend %s from an incoming raid.",
			"%s is a community on edge, as the looming threat of southern raiders casts a pall over daily life.",
			"In these troubled times %s seeks sellswords - the more ruthless the better - to deter the threat of southern invaders.",
			"%s seeks valiant sellswords - you assume the \'valiant\' part is optional - to defend against southern raiders.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			if (this.m.Home != null)
				r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
			else if (this.m.Origin != null)
				r = format(r, ::Const.UI.getColorized(this.m.Origin.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				local end = s.end;
				s.end <- function ()
				{
					end();
					foreach (id in this.Contract.m.UnitsSpawned) {
						local party = ::World.getEntityByID(id);
						party.getLoot().Money = this.Math.rand(100, 300);
						party.getLoot().ArmorParts = this.Math.rand(10, 35);
						party.getLoot().Medicine = this.Math.rand(5, 15);
						party.getLoot().Ammo = this.Math.rand(10, 40);
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
