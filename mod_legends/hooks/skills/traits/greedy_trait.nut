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
		local bonusText = this.m.Bonus == 0 ? "No attribute bonus" : ("[color=%positive%]" + ::Legends.S.addSign(this.m.Bonus) + "[/color] to every attribute");
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
				text = bonusText + " due to their current wage"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.DailyWageMult *= 1.25;
		local dailyCost = this.getContainer().getActor().getDailyCost();
		this.m.Bonus = ::Math.floor(dailyCost / ::Math.pow(10, (1.2 + ::Math.minf(dailyCost / 1000.0, 0.5))));
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
