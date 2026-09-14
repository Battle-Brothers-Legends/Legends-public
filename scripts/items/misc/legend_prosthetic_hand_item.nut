this.legend_prosthetic_hand_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_hand";
		this.m.Name = "Prosthetic Hand";
		this.m.Description = "An exceptional creation, this prosthetic hand has articulated joints which can be manipulated to hold objects and even give the finger in a pinch.";
		this.m.Icon = "consumables/prosthetic_hand.png";
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
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "User will no longer be blocked from using shields, two-handed weapons, throwing nets and from double gripping one-handed weapons"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-10%[/color] Melee Defense when using a shield"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10%[/color] Ranged Defense when using a shield"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-10%[/color] Melee Skill when NOT using a shield"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-10%[/color] Ranged Skill when NOT using a shield"
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
				text = "Can only be used if this character has a missing hand"
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
		if (_actor.getSkills().hasSkill("injury.missing_hand"))
		{
			::Legends.Traits.grant(_actor, ::Legends.Trait.LegendProstheticHand);
			_actor.getSkills().removeByID("injury.missing_hand");
			return true;
		}
		return false;
	}
});

