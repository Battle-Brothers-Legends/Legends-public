this.legend_huge_quiver_of_bolts <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.bolts";
		this.m.Name = "Huge Quiver of Bolts";
		this.m.Description = "A huge quiver of bolts, required to use crossbows. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_06.png";
		this.m.IconEmpty = "ammo/quiver_06_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Bolts;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 4000;
		this.m.Ammo = 20;
		this.m.AmmoMax = 20;
		this.m.StaminaModifier = -4;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Contains [color=%positive%]" + this.m.Ammo + "[/color] bolts"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Is empty and useless[/color]"
			});
		}

		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=%negative%]" + this.m.StaminaModifier + "[/color] fatigue"
		});

		return result;
	}

});

