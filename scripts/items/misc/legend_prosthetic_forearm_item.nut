this.legend_prosthetic_forearm_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_forearm";
		this.m.Name = "Prosthetic Forearm";
		this.m.Description = "According to the inventor, this contraption is almost like the real thing. If the real thing had no feeling and control in their forearm, of course. It can hold a weapon, even if the fingers need to be adjusted with the other hand. Mercenaries particularly enjoy setting their new hand to give the one finger salute.";
		this.m.Icon = "consumables/prosthetic_forearm.png";
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
				icon = "ui/icons/melee_skill.png",
				text = "Reduces the penalty of Broken Elbow Joint to [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Reduces the penalty of Broken Elbow Joint to [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Ranged Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Reduces the penalty of Broken Elbow Joint to [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Defense"
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
				text = "Can only be used if this character has a broken elbow joint"
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
		if (_actor.getSkills().hasSkill("injury.broken_elbow_joint"))
		{
			_actor.getSkills().add(this.new("scripts/skills/traits/legend_prosthetic_forearm"));
			_actor.getSkills().removeByID("injury.broken_elbow_joint");
			return true;
		}
		return false;
	}
});

