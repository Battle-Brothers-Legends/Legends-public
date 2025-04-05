::mods_hookExactClass("items/tools/acid_flask_item", function(o) {
	o.m.OriginalValue <- null;
	o.m.OriginalDescription <- null;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "A flask filled with the concentrate of a Lindwurm\'s acidic blood. It is highly corrosive to many materials and burns through armor quickly.";
		this.m.OriginalDescription = this.m.Description;
		this.m.Value = 1100;
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
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the target\'s armor by [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] each turn for 3 turns"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] chance to hit bystanders at the same or lower height level as well"
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

	o.consumeAmmo <- function()
	{
		this.m.AmmoCost = 0;
		this.weapon.consumeAmmo(); // to prevent scavenger retinue from recover ammo part
		this.m.AmmoCost = 30;
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

	o.setAmmo <- function ( _a )
	{
		this.weapon.setAmmo( _a );

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Acid Flask";
			this.m.IconLarge = "tools/acid_flask_01.png";
			this.m.Icon = "tools/acid_flask_01_70x70.png";
			this.m.ShowArmamentIcon = true;
			this.m.Description = this.m.OriginalDescription;
			this.m.Value = m.OriginalValue;
		}
		else
		{
			this.m.Name = "Acid Flask (Used)";
			this.m.IconLarge = "tools/acid_flask_01.png";
			this.m.Icon = "tools/acid_flask_01_70x70.png";
			this.m.ShowArmamentIcon = false;
			this.m.Description = "A spent and shattered flask. If the company has \"Alchemy Tools\", this item is refilled after each battle, consuming 30 ammunition per use.";
			this.m.Value = 0;
		}

		this.updateAppearance();
	}

	o.onPutIntoBag <- function ()
	{
		local skill = ::Legends.Actives.get(this, ::Legends.Active.LegendLaunchAcidFlask)
		if (skill != null)
			skill.setItem(this);
	}

	o.onRemovedFromBag <- function()
	{
		this.item.onRemovedFromBag();
		local skill = ::Legends.Actives.get(this, ::Legends.Active.LegendLaunchAcidFlask)
		if (skill != null)
			skill.setItem(null);
	}
});