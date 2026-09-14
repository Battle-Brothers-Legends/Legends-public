this.legend_basilisk_trophy_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_basilisk_trophy";
		this.m.Name = "Basilisk Trophy Necklace";
		this.m.Description = "This trophy fashioned from an eye and feathers of a Basilisk stares blankly at those next to die on the battlefield";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/basilisk_trophy.png";
		this.m.Sprite = "basilisk_trophy"; //pulled from XML file under entity -> details
		this.m.Value = 1125;
	}

	function getTooltip() //necklace gives a headhunter effect when taking hp damage
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

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Gain [color=%positive%]+5%[/color] chance to hit the head"
		});

		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Deal [color=%positive%]+20%[/color] more damage when hitting the head with any weapon"
		});
		return result;
	}

	function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.2;
	}

});

