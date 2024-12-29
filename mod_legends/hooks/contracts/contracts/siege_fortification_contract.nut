::mods_hookExactClass("contracts/contracts/siege_fortification_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Laying Siege";
		this.m.DescriptionTemplates = [
			"Sieges often lead to violent, unpredictable outcomes. %s are seeking hardened sellswords to provide a steadying hand should things turn to ratshit.",
			"Finishing a siege is always a dicey business. %s wants some hardened mercenaries to tip the odds.",
			"Dying with an arrow in your gut from attacking a fortified position is not exactly high in your list of priorities.",
			"Siege actions nearly always turn to ratshit in your experience. Probably why %s wants you down there.",
		];
	}

	local start = o.start;
	o.start = function ()
	{
		start();
		this.m.Name = "Siege %objective%";
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
			if (s.ID == "PrisonersLetGo")
			{
				s.Text = "Enough death for one day. (Increase Moral Reputation)";
			}
			if (s.ID == "PrisonersKilled")
			{
				s.Text = "On to more important things... (Decrease Moral Reputation)";
			}
			if (s.ID == "PrisonersSold")
			{
				s.Text = "On to more important things... (Decrease Moral Reputation)";
				s.start <- function ()
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]250[/color] Crowns"
					});
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
		}
	}

	local spawnReliefForces = o.spawnReliefForces;
	o.spawnReliefForces = function () {
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local party = null;
		f.setSpawnListener(function(entity) {
			party = entity;
		});
		spawnReliefForces();
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
	}

});
