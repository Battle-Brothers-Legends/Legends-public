::mods_hookExactClass("items/accessory/accessory", function(o) {
	o.m.StashModifier <- 0;
	o.m.InventorySound <- "sounds/combat/armor_leather_impact_03.wav";

	o.getStashModifier <- function ()
	{
		return this.m.StashModifier;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		if (this.m.StaminaModifier > 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.StashModifier > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/bag.png",
				text = "Provides [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.StashModifier + "[/color] stash spaces. If you remove this accessory, spaces at the bottom of the stash will be lost, along with any items in those spaces."
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		if (this.m.StashModifier > 0)
		{
			if (this.World.State.getPlayer() == null)
			{
				return;
			}
			this.World.State.getPlayer().calculateStashModifier()
		}

	}

	o.playInventorySound <- function ( _eventType )
	{
		this.Sound.play(this.m.InventorySound, this.Const.Sound.Volume.Inventory);
	}

	local onUnequip = o.onUnequip;
	o.onUnequip = function ()
	{
		onUnequip();

		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		if (this.m.StashModifier > 0)
		{
			this.getContainer().unequipNoUpdate(this);
			this.World.State.getPlayer().calculateStashModifier()
		}

	}

	o.onUpdateProperties = function ( _properties )
	{
		if (!this.isInBag()) // if the item is in the bag, the bag_fatigue skill will apply the stamina modifier
		{
			_properties.Stamina += getStaminaModifier();
		}
	}

});