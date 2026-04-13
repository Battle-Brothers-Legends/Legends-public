::mods_hookExactClass("skills/traits/greedy_trait", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "I want more! This character is greedy and will demand a higher daily payment than others with a similar background, as well as being fast to leave you if you ever run out of crowns. On the flip side, ever eager for danger pay, this character performs better the higher the wage. Gains 1 to each attribute for every 10 gold in daily wage paid.";
	}

	o.getTooltip = function ()
	{
		local bonus = this.Math.floor(this.getContainer().getActor().getDailyCost() / 10.0);
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
				text = "[color=%positive%]" + bonus + "[/color] to every attribute"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.DailyWageMult *= 1.25;
		local bonus = this.Math.floor(this.getContainer().getActor().getDailyCost() / 10.0);
		_properties.Hitpoints += bonus;
		_properties.Bravery += bonus;
		_properties.Stamina += bonus;
		_properties.Initiative += bonus;
		_properties.MeleeSkill += bonus;
		_properties.RangedSkill += bonus;
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}
});
