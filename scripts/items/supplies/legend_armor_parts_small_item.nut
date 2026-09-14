this.legend_armor_parts_small_item <- this.inherit("scripts/items/item", {
	m = {
		Amount = 0
	},
	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Amount;
	}

	function getAmount()
	{
		return this.m.Amount;
	}

	function setAmount( _a )
	{
		this.m.Amount = this.Math.floor(_a);
	}

	function create()
	{
		this.item.create();
		this.m.ID = "supplies.legend_armor_parts_small";
		this.m.Name = "Small Tools and Supplies";
		this.m.Icon = "supplies/armor_parts_small.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Supply;
		this.m.IsConsumed = true;
		this.m.Value = 100;
		this.m.Amount = 10;
	}

	function getValue()
	{
		return this.Math.floor(this.m.Amount / 10.0 * this.m.Value);
	}

	function getBuyPrice()
	{
		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.workshop") || this.World.State.getCurrentTown().hasAttachedLocation("attached_location.leather_tanner") || this.World.State.getCurrentTown().hasBuilding("building.armorsmith") || this.World.State.getCurrentTown().hasBuilding("building.weaponsmith");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? 1.0 : 1.5)));
		}

		return this.item.getBuyPrice();
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
				text = "A good [color=%positive%]" + this.m.Amount + "[/color] assorted tools and supplies to repair weapons, armor, helmets and shields with after battle. Will be added to your global stock once you\'re back on the worldmap."
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
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function consume()
	{
		this.World.Assets.addArmorParts(this.m.Amount);
	}

});
