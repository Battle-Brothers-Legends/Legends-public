this.legend_prosthetic_hand <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticHand);
		this.m.Name = "Prosthetic Hand";
		this.m.Icon = "ui/traits/legend_prosthetic_hand.png";
		this.m.Description = "Fine craftsmanship allows the wearer of this prosthetic to articulate the joints with some effort, allowing the fingers to be bent to hold a shield or a sword. Of course, you lose quite a bit of finesse with such an item.";
		if (this.m.IsUpgraded)
		{
			this.m.Name = "Enhanced Prosthetic Hand";
			this.m.Description = "A masterwork prosthetic hand which articulates joints without resistance. The fingers grip whatever they are holding very tightly, making it near impossible to knock a weapon from this hand. Spikes were added to make punches hurt even more.";
		}
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}];

		local malus = this.m.IsUpgraded ? 5 : 10;
		ret.extend([{
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%negative%]-" + malus + "%[/color] Melee Defense when using a shield"
		},
		{
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%negative%]-" + malus + "%[/color] Ranged Defense when using a shield"
		},
		{
			id = 12,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=%negative%]-" + malus + "%[/color] Melee Skill when NOT using a shield"
		},
		{
			id = 13,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=%negative%]-" + malus + "%[/color] Ranged Skill when NOT using a shield"
		}]);

		if (this.m.IsUpgraded)
		{
			ret.extend([
				{
					id = 14,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=%negative%]-" + malus + "%[/color] Melee Skill when NOT using a shield"
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=%negative%]-" + malus + "%[/color] Ranged Skill when NOT using a shield"
				}
			]);
		}
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
