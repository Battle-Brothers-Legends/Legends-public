::mods_hookExactClass("skills/traits/huge_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Being particularly huge and burly, this character\'s strikes hurt plenty, but they\'re also a bigger target than most.";
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail)
		]);
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
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] Melee Damage increase"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] Ranged Damage increase"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Ranged Defense"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.MeleeDamageMult *= 1.05;
		_properties.RangedDamageMult *= 1.05;
		_properties.MeleeDefense -= 5;
		_properties.RangedDefense -= 5;
	}
});
