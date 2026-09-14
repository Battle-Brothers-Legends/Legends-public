::mods_hookExactClass("items/tools/throwing_net", function(o) {
	o.m.OriginalDescription <- "";
	o.m.OriginalValue <- 0;
	o.m.OwnerID <- null;
	o.m.OriginalAmmoCost <- 0;

	o.isAmountShown <- function()
	{
		return true;
	}

	o.getAmountString <- function()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.isDroppedAsLoot <- function()
	{
		return this.item.isDroppedAsLoot();
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OriginalValue = this.m.Value;
		this.m.OriginalDescription = this.m.Description;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Net;
		this.m.OriginalAmmoCost = 15;
		this.m.AmmoCost = this.m.OriginalAmmoCost;
		this.m.AmmoMax = 1;
		this.m.Ammo = 1;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local result = getTooltip();

		for (local i = result.len() - 1; i >= 0; --i) {
			if (result[i].type == "text" && result[i].id == 8) {
				result[i].text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]";
			}

			if (result[i].type == "text" && result[i].text == "Is destroyed on use") {
				result.remove(i);
			}			
		}

		if (this.m.Ammo <= 0){
			result.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Is broken and useless[/color]"
			});
		}
		return result;
	}

	o.addSkill <- function( _skill )
	{
		if (::Legends.Actives.getID(::Legends.Active.ThrowNet) && this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetCasting))
			_skill.m.MaxRange = 5;

		this.weapon.addSkill(_skill);
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
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair))
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
		this.m.OwnerID = _id;
	}

	o.setAmmo <- function( _a )
	{
		this.weapon.setAmmo(_a);
		this.updateAmmo();
	}

	o.consumeAmmo <- function()
	{
		this.m.AmmoCost = 0;
		this.weapon.consumeAmmo(); // to prevent scavenger retinue from recover ammo part
		this.m.AmmoCost = this.m.OriginalAmmoCost;
	}

	o.updateAmmo <- function()
	{
		if (this.m.Ammo > 0) {
			this.m.Name = "Throwing Net";
			this.m.Description = this.m.OriginalDescription;
			this.m.IconLarge = "tools/inventory_throwing_net.png";
			this.m.Icon = "tools/throwing_net_70x70.png";
			this.m.ShowArmamentIcon = true;
			this.m.Value = this.m.OriginalValue;
		}
		else {
			this.m.Name = "Broken Throwing Net";
			this.m.Description = "A broken net that may be repaired if you have the knowledge, or sold for scrap. (requires \"Net Repair\" perk to refill its charge)";
			this.m.IconLarge = "tools/inventory_throwing_net_broken.png";
			this.m.Icon = "tools/throwing_net_broken_70x70.png";
			this.m.ShowArmamentIcon = false;
			this.m.Value = 0;
		}

		this.updateAppearance();
	}

	o.onDeserialize <- function( _in )
	{
		this.weapon.onDeserialize(_in);
		this.updateAmmo();
	}

});
