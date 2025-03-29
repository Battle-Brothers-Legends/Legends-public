this.legend_prosthetic_hand <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticHand);
		this.m.Name = "Prosthetic Hand";
		this.m.Icon = "ui/traits/legend_prosthetic_hand.png";
		this.m.Description = "Fine craftsmanship allows the wearer of this prosthetic to articulate the joints with some effort, allowing the fingers to be bent to hold a shield or a sword. Of course, you lose quite a bit of finesse with such an item.";
	}

	function getTooltip()
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Melee Defense when using a shield"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Ranged Defense when using a shield"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Melee Skill when NOT using a shield"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Ranged Skill when NOT using a shield"
			}
		];
	}

	function newhandShield()
	{
		local shield = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return shield != null && shield.isItemType(this.Const.Items.ItemType.Shield);
	}

	function onUpdate (_properties)
	{
		if (this.newhandShield())
		{
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
		}
		if (!this.newhandShield())
		{
			_properties.MeleeSkillMult *= 0.9;
			_properties.RangedSkillMult *= 0.9;
		}
	}
});
