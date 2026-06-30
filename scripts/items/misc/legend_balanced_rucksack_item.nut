this.legend_balanced_rucksack_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_balanced_rucksack";
		this.m.Name = "Balanced Rucksack";
		this.m.Description = "A backpack worn by journeying sellswords, which allows easily reachable weapons and tools should their travels demand it.";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Icon = "consumables/legend_balanced_rucksack.png";
		this.m.Value = 2000;
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the user [color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] bag slots"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has no effect if the user has the Bags and Belts perk"
		});

		return result;
	}
	
	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}
	
	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_01.wav", this.Const.Sound.Volume.Inventory);
		if (!_actor.getSkills().hasPerk(::Legends.Perk.BagsAndBelts)) {
			::Legends.Perks.grant(this, ::Legends.Perk.BagsAndBelts, function (perk) {
				if (!this.getBackground().addPerk(::Legends.Perk.BagsAndBelts, 0, false))
					this.getBackground().m.PerkTreeMap[perk.getID()].IsRefundable = false;
			}.bindenv(this));
			return true;
		}
		else
		{
			return false;
		}
	}

});

