this.legend_broad_head_arrows <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.legend_broad_head_arrows";
		this.m.Name = "Broad Head Arrows";
		this.m.Description = "A quiver of arrows, required to use bows of all kinds. Is automatically refilled after each battle if you have enough ammunition. Grants -20% armor piercing and +10% damage while wielding a bow.";
		this.m.Icon = "ammo/quiver_light.png";
		this.m.IconEmpty = "ammo/quiver_01_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 100;
		this.m.Ammo = 10;
		this.m.AmmoMax = 10;
		this.m.IsDroppedAsLoot = true;
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
				text = "Contains [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] arrows"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.ammo.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item == null)
		{
			return;
		}
		
		switch (item.getID())
		{
			case "weapon.wonky_bow":
			case "weapon.war_bow":
			case "weapon.hunting_bow":
			case "weapon.masterwork_bow":
			case "weapon.short_bow":	
			case "weapon.goblin_bow":
			case "weapon.goblin_heavy_bow":
			case "weapon.named_goblin_heavy_bow":	
				_properties.DamageDirectMult -= 0.2;
				_properties.RangedDamageMult *= 1.1;
					break;

	}
});

