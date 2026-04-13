this.legend_prosthetic_finger_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_finger";
		this.m.Name = "Prosthetic Finger";
		this.m.Description = "A wooden finger with a joint for the user to force it into whatever position they need. Perfect for pointing fingers at people, but not too much else.";
		this.m.Icon = "consumables/prosthetic_finger.png";
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
			},
			{
				id = 66,
				type = "text",
				text = this.getValueString()
			}
		];

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
				icon = "ui/icons/melee_skill.png",
				text = "Reduces the penalty of Missing Finger to [color=%negative%]-2%[/color] Melee Skill"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Reduces the penalty of Missing Finger to [color=%negative%]-2%[/color] Ranged Skill"
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
				text = "Can only be used if this character has a missing finger"
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
		if (_actor.getSkills().hasSkill("injury.missing_finger"))
		{
			::Legends.Traits.grant(_actor, ::Legends.Trait.LegendProstheticFinger);
			_actor.getSkills().removeByID("injury.missing_finger");
			return true;
		}
		return false;
	}
});

