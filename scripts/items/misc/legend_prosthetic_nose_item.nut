this.legend_prosthetic_nose_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_prosthetic_nose";
		this.m.Name = "Prosthetic Nose";
		this.m.Description = "Nobody gaveth a damn who I was until I putteth on the mask. A faux nose attached to a strap, it allows the wearer to breath with less difficulty.";
		this.m.Icon = "consumables/prosthetic_nose.png";
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

		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Reduces the penalty of Missing Nose to [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Max Fatigue"
		});

		if (!("getActor" in this.getContainer())) {
			return result;
		}

		if (this.getContainer().getActor().getSkills().hasSkill("injury.missing_nose"))
		{
			result.push({
				id = 65,
				type = "text",
				text = "Right-click or drag onto the currently selected character in order to apply it. This item will be consumed in the process."
			});
		}
		else
		{
			result.push({
				id = 65,
				type = "text",
				text = "Item can not be used, because this character still has his nose intact"
			});
		}
		return result;
	}

	function isUsable()
	{
		return this.getContainer().getActor().getSkills().hasSkill("injury.missing_nose") && this.m.IsUsable;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/traits/legend_prosthetic_nose"));
		actor.getSkills().removeByID("injury.missing_nose");

		return true;
	}
});

