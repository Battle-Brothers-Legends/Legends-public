this.legend_broad_head_bolts <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.bolts";
		this.m.Name = "Broad Head Bolts";
		this.m.Description = "A quiver of bolts with broad tips, designed for tearing flesh, but easily stopped by armor. Is automatically refilled after each battle if you have enough global ammunition. Grants +10% damage but -10% armor piercing damage while wielding a crossbow.";
		this.m.Icon = "ammo/quiver_02_light.png";
		this.m.IconEmpty = "ammo/quiver_02_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Bolts;
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
				text = "Contains [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] bolts"
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
		if (_skill.isAttack() && _skill.getItem() != null && _skill.getItem().isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			_properties.DamageDirectMult *= 0.9;
			_properties.RangedDamageMult *= 1.1;
		}
	}
});

