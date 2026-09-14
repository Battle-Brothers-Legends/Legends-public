::mods_hookExactClass("skills/traits/greedy_trait", function(o)
{
	o.m.Bonus <- 0;
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "I want more! This character is greedy and will demand a higher daily payment than others with a similar background, as well as being fast to leave you if you ever run out of crowns. On the flip side, ever eager for danger pay, this character performs better the higher the wage. The bonus has diminishing returns.";
	}

	o.getTooltip = function ()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%positive%]" + this.m.Bonus + "[/color] to every attribute"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.DailyWageMult *= 1.25;
		local dailyCost = this.getContainer().getActor().getDailyCost();
		this.m.Bonus = this.Math.floor(dailyCost / this.Math.pow(10, (1.2 + this.Math.minf(dailyCost / 1000.0, 0.5))));
		_properties.Hitpoints += this.m.Bonus;
		_properties.Bravery += this.m.Bonus;
		_properties.Stamina += this.m.Bonus;
		_properties.Initiative += this.m.Bonus;
		_properties.MeleeSkill += this.m.Bonus;
		_properties.RangedSkill += this.m.Bonus;
		_properties.MeleeDefense += this.m.Bonus;
		_properties.RangedDefense += this.m.Bonus;
	}
});
