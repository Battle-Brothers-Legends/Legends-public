this.legend_prosthetic_leg_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_leg";
		this.m.Name = "Prosthetic Leg";
		this.m.Description = "This peg leg is pretty heavy and would be difficult to walk in. But it does allow a mercenary to walk with a certain agility retained. Holding it you feel like singing in a shanty for some reason.";
		this.m.Icon = "consumables/prosthetic_leg.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = false;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 0;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Reduces the penalty of Broken Knee to [color=%negative%]-15%[/color] Melee Skill"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Reduces the penalty of Broken Knee to [color=%negative%]-15%[/color] Ranged Skill"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Reduces the penalty of Broken Knee to [color=%negative%]-20%[/color] Initiative"
			},
			{
				id = 65,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Right-click or drag onto the currently selected character in order to apply it. This item will be consumed in the process."
			},
			{
				id = 65,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Can only be used if this character has a broken knee"
			}
		]);

		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
		if (_actor.getSkills().hasSkill("injury.broken_knee"))
		{
			::Legends.Traits.grant(_actor, ::Legends.Trait.LegendProstheticLeg);
			_actor.getSkills().removeByID("injury.broken_knee");
			return true;
		}
		return false;
	}
});

