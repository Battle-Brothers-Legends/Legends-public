::mods_hookExactClass("skills/actives/web_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IconDisabled = "skills/active_114_sw.png";
		this.m.Description = "Send a web of silk out to ensnare an opponent, rooting them in place halving their damage, defenses and initiative. Does no damage.";
	}

	o.getTooltip <- function ()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		if (this.m.Cooldown != 0)
		{
			tooltip.extend([
				{
					id = 6,
					type = "text",
					text = "Has " + this.m.Cooldown + " turns left."
				}
			]);
		}
		return tooltip;
	}
});
