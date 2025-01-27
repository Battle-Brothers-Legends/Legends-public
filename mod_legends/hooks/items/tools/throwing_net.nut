::mods_hookExactClass("items/tools/throwing_net", function(o) {
	o.m.OriginalDescription <- "";
	o.m.OriginalValue <- 0;
	o.m.OwnerID <- null;

	o.isAmountShown <- function()
	{
		return true;
	}

	o.getAmountString <- function()
	{
		return m.Ammo + "/" + m.AmmoMax;
	}

	o.getAmmo <- function() // prevent net from being refilled without the perk
	{
		return m.Ammo == 0 && !::World.Statistics.getFlags().get("LegendsCanRepairNet") ? m.AmmoMax + 1 : m.Ammo;
	}

	o.isDroppedAsLoot <- function()
	{
		return item.isDroppedAsLoot();
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		m.OriginalValue = m.Value;
		m.OriginalDescription = m.Description;
		m.ItemType = m.ItemType | ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Net;
		m.AmmoCost = 20;
		m.AmmoMax = 1;
		m.Ammo = 1;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local result = getTooltip();

		for (local i = result.len() - 1; i >= 0; --i)
		{
			if (result[i].type == "text" && result[i].text == "Is destroyed on use") {
				result.remove(i);
				break;
			}
		}

		if (m.Ammo <= 0)
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Is broken and useless[/color]"
			});

		return result;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.throw_net" && getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetCasting))
			_skill.m.MaxRange = 5;

		weapon.addSkill(_skill);
	}

	o.onUpdateProperties <- function ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair))
			_properties.Stamina -= this.m.StaminaModifier;
	}

	// Bag fatigue uses getStaminaModifier
	o.getStaminaModifier <- function ()
	{
		if (!::MSU.isNull(getContainer()) && !::MSU.isNull(getContainer().getActor()) && getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair))
		{
			return 0;
		}
		else
		{
			return this.m.StaminaModifier;
		}
	}

	o.setOwnerID <- function( _id )
	{
		m.OwnerID = _id;
	}

	o.setAmmo <- function( _a )
	{
		weapon.setAmmo(_a);
		updateAmmo();
	}

	o.consumeAmmo <- function()
	{
		m.AmmoCost = 0;
		weapon.consumeAmmo(); // to prevent scavenger retinue from recover ammo part
		m.AmmoCost = 20;
	}

	o.updateAmmo <- function()
	{
		if (m.Ammo > 0) {
			m.Name = "Throwing Net";
			m.Description = m.OriginalDescription;
			m.IconLarge = "tools/inventory_throwing_net.png";
			m.Icon = "tools/throwing_net_70x70.png";
			m.ShowArmamentIcon = true;
			m.Value = m.OriginalValue;
		}
		else {
			m.Name = "Broken Throwing Net";
			m.Description = "A broken net that may be repaired if you have the knowledge, or sold for scrap. (requires \"Net Repair\" perk to refill its charge)";
			m.IconLarge = "tools/inventory_throwing_net_broken.png";
			m.Icon = "tools/throwing_net_broken_70x70.png";
			m.ShowArmamentIcon = false;
			m.Value = 0;
		}

		updateAppearance();
	}

	o.onDeserialize <- function( _in )
	{
		weapon.onDeserialize(_in);
		updateAmmo();
	}

});
