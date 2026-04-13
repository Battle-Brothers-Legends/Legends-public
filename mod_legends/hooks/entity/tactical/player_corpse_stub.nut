::mods_hookExactClass("entity/tactical/player_corpse_stub", function(o)
{
	o.m.IsCommander <- false;
	o.m.Gender <- -1;

	o.setCommander <- function ( _f )
	{
		this.m.IsCommander = _f;
	}

	o.isCommander <- function ()
	{
		return this.m.IsCommander;
	}

	o.setGender <- function ( _gender )
	{
		this.m.Gender = _gender;
	}

	o.getGender <- function ()
	{
		return this.m.Gender;
	}

	o.getRosterTooltip = function ()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.m.DaysWithCompany;
		local text;

		if (time == -1)
		{
			text = "With the company from the very beginning.";
		}
		else if (time > 1)
		{
			text = "With the company for " + time + " days.";
		}
		else
		{
			text = "Had just joined the company.";
		}

		if (this.m.LifetimeStats.Battles != 0)
		{
			text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battles and has " + this.m.LifetimeStats.Kills + " kills.");
		}

		if (this.m.LifetimeStats.MostPowerfulVanquished != "")
		{
			local vanquishedText = "{" + (" The most powerful opponent %they% vanquished was " + this.m.LifetimeStats.MostPowerfulVanquished + ".") + "}";
			local vars = [];
			::Const.LegendMod.extendVarsWithPronouns(vars, this);
			vanquishedText = this.buildTextFromTemplate(vanquishedText, vars);
			text = text + vanquishedText;
		}

		tooltip.push({
			id = 2,
			type = "description",
			text = text
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "Level " + this.m.Level
		});

		if (this.m.DailyCost != 0)
		{
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = "Paid [img]gfx/ui/tooltips/money.png[/img]" + this.m.DailyCost + " daily"
			});
		}

		return tooltip;
	}
});
