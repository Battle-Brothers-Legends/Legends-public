this.legend_prosthetic_foot_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_foot";
		this.m.Name = "Prosthetic Foot";
		this.m.Description = "It\'s more than a prosthetic foot, it\'s a foundation! Or so it\'s creator says, but this contraption looks like hell to walk with. Crafted out of wood, metal and various leather straps, it manages to mimic foot movement well enough and will allow the wearer to at least recover a part of their dexterity.";
		this.m.Icon = "consumables/prosthetic_foot.png";
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
				icon = "ui/icons/action_points.png",
				text = "Removes the [color=%negative%]1[/color] Additional Action Point per tile moved penalty from Maimed Foot Injury"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Reduces the penalty of Missing Foot to [color=%negative%]-10%[/color] Initiative"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Builds up [color=%negative%]3[/color] more fatigue for each tile travelled"
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
				text = "Can only be used if this character has a maimed foot"
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
		if (_actor.getSkills().hasSkill("injury.maimed_foot"))
		{
			::Legends.Traits.grant(_actor, ::Legends.Trait.LegendProstheticFoot);
			_actor.getSkills().removeByID("injury.maimed_foot");
			return true;
		}
		return false;
	}
});

