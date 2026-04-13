this.legend_glove_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		RegularDamage = 0,
		RegularDamageMax = 0,
		ChokeMin = 0,
		ChokeMax = 0,
		ArmorDamageMult = 0,
		DirectDamageMult = 0,
		InventorySound = ""
	},
	function create()
	{
		this.accessory.create();
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Brawler;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
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

		result.extend(
		[
			{
				id = 4,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=%damage%]+" + this.m.RegularDamage + "-" + this.m.RegularDamageMax + "[/color] more damage with Hand to Hand"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=%damage%]+" + this.m.ChokeMin + "-" + this.m.ChokeMax + "[/color] more damage with Choke"
			}
		]);

		if (this.m.ArmorDamageMult > 0.0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=#400080]Hand to Hand[/color] is [color=%damage%]" + this.Math.floor((this.m.ArmorDamageMult + 0.5) * 100) + "%[/color] effective against armor"
			});
		}

		if (this.m.DirectDamageMult > 0.0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=#400080]Hand to Hand[/color] has [color=%damage%]" + this.Math.floor((this.m.DirectDamageMult + 0.1) * 100) + "%[/color] armor ignore"
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 15,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]" + this.m.StaminaModifier + "[/color] Fatigue."
			});
		}
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.InventorySound, this.Const.Sound.Volume.Inventory);
	}

	function getIconOverlay()
	{
		local L = [];

		if (this.isNamed())
		{
			if (this.isItemType(::Const.Items.ItemType.Legendary))
				L.push("layers/legendary_icon_glow.png");
			else
				L.push("layers/named_icon_glow.png");
		}

		L.push(this.m.Icon);

		if (L.len() == 0)
		{
			return [""];
		}

		return L;
	}
});
