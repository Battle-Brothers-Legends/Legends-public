this.legend_armor_piercing_arrows <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.arrows";
		this.m.Name = "Armor Piercing Arrows";
		this.m.Description = "A quiver of arrows with piercing tips, designed for punching through thick armor. Is automatically refilled after each battle if you have enough ammunition. Grants +30% (multiplicative) armor piercing and -10% damage while wielding a bow.";
		this.m.Icon = "ammo/quiver_01_dark.png";
		this.m.IconEmpty = "ammo/quiver_01_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 350;
		this.m.Ammo = 10;
		this.m.AmmoMax = 10;
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.getItem() != null && _skill.getItem().isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			_properties.DamageDirectMult *= 1.3;
			_properties.RangedDamageMult *= 0.9;
		}
	}

});

