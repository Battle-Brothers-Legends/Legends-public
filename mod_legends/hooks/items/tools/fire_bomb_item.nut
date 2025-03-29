::mods_hookExactClass("items/tools/fire_bomb_item", function(o) {
	o.m.OriginalValue <- null;
	o.m.OriginalDescription <- null;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "A pot filled with highly flammable liquid that will set an area ablaze with fire when thrown.";
		this.m.OriginalDescription = this.m.Description;
		this.m.Value = 1300;
		this.m.OriginalValue = this.m.Value;
		this.m.ItemType = this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Tool;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 30;
		this.m.RangeMax = 3;
	}

	o.getTooltip = function()
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

		result.extend([
		{
			id = 66,
			type = "text",
			text = this.getValueString()
		},
		{
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		},
		{
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will set [color=" + this.Const.UI.Color.DamageValue + "]7[/color] tiles ablaze with burning fire for 2 rounds"
		}]);

		if (!this.World.Retinue.hasFollower("follower.alchemist"))
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be refilled after battle, because this company has no Alchemy Tools"
			});
		}
		return result;
	}

	o.isAmountShown <- function ()
	{
		return true;
	}

	o.getAmountString <- function ()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.getAmmo <- function() // prevent item from being refilled without the retinue
	{
		return m.Ammo == 0 && !this.World.Retinue.hasFollower("follower.alchemist") ? m.AmmoMax + 1 : m.Ammo;
	}

	o.consumeAmmo <- function()
	{
		m.AmmoCost = 0;
		weapon.consumeAmmo(); // to prevent scavenger retinue from recover ammo part
		m.AmmoCost = 30;
	}

	o.setAmmo <- function ( _a )
	{
		this.weapon.setAmmo( _a );

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Fire Pot";
			this.m.Description = m.OriginalDescription;
			this.m.IconLarge = "tools/fire_pot_01.png";
			this.m.Icon = "tools/fire_pot_01_70x70.png";
			this.m.ShowArmamentIcon = true;
			this.m.Value = m.OriginalValue;
		}
		else
		{
			this.m.Name = "Fire Pot (Used)";
			this.m.Description = "A spent and shattered pot. If the company has \"Alchemy Tools\", this item is refilled after each battle, consuming 30 ammunition per use.";
			this.m.IconLarge = "tools/fire_pot_01.png";
			this.m.Icon = "tools/fire_pot_01_70x70.png";
			this.m.ShowArmamentIcon = false;
			this.m.Value = 0;
		}

		this.updateAppearance();
	}
});