::mods_hookExactClass("skills/traits/player_character_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This is your player character, or in other words, yourself. If they die, your campaign ends. You can\'t dismiss them, they\'re immune to charm effects, and they\'ll never desert you.";
		this.m.Excluded.extend(
		[
			"trait.loyal",
			"trait.disloyal",
			"trait.greedy"
		]);
	}

	local getTooltip = o.getTooltip;
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]Immune to charm effects.[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]Will never desert the company.[/color]"
			}
		];
	}
});
