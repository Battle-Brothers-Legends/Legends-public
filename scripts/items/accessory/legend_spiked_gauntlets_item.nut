this.legend_spiked_gauntlets_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		isBrawlerItem = true
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_spiked_gauntlets";
		this.m.Name = "Spiked Gauntlets";
		this.m.Description = "A pair of armored gauntlets with spikes on the knuckles that can certainly pack a punch, but also help deflect blows from weak spots.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/spiky_gauntlets.png";
		this.m.Value = 2600;
		this.m.StaminaModifier = -3;
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
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+6-12[/color] more damage on unarmed attacks."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] more armor damage (additive) on unarmed attacks."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Melee Defense."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Fatigue."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Allows you to grapple any weapon on unarmed attacks"
			}
		]);
		return result;
	}

	function onUpdateProperties ( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.MeleeDefense += 2;
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_halfplate_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}
});
