this.legend_ammo_small_item <- this.inherit("scripts/items/item", {
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
		this.m.Amount = ::Math.floor(_a);
	}

	function create()
	{
		this.item.create();
		this.m.ID = "supplies.legend_ammo_small";
		this.m.Name = "Small Ammunition";
		this.m.Icon = "supplies/ammo_small.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Supply;
		this.m.IsConsumed = true;
		this.m.Value = 50;
		this.m.Amount = 25;
	}

	function getValue()
	{
		return ::Math.floor(this.m.Amount / 25.0 * this.m.Value);
	}

	function getBuyPrice()
	{
		if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = ::World.State.getCurrentTown().hasAttachedLocation("attached_location.fletchers_hut") || ::World.State.getCurrentTown().hasBuilding("building.fletcher");
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::Const.Difficulty.BuyPriceMult[::World.Assets.getEconomicDifficulty()] * ::World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? 1.0 : 1.5)));
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
				text = "A good [color=%positive%]" + this.m.Amount + "[/color] units of assorted ammunition - arrows, bolts and javelins. Used to automatically refill your quivers after battle. Will be added to your global stock once you\'re back on the worldmap."
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
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

	function consume()
	{
		::World.Assets.addAmmo(this.m.Amount);
	}

});
