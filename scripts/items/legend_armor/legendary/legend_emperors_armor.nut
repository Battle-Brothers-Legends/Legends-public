this.legend_emperors_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.legend_emperors_armor";
		this.m.Name = "The Emperor\'s Armor";
		this.m.Description = "A shining armor once worn by the emperor of an age long past, made from the most woundrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 20000;
		this.m.Condition = 350;
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -35;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "At the start of your turn, apply the Dazed status effect to all nearby enemies"
		});
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local actors = this.Tactical.Entities.getAllInstances();
		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getID() == actor.getID())
					continue;

				if (actor.getTile().getDistanceTo(a.getTile()) > 2)
					continue;

				if (a.isAlliedWith(actor))
					continue;

				if (!a.getCurrentProperties().IsImmuneToDaze)
					a.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}
	}

	function updateVariant()
	{
		this.m.SpriteBack = "bust_named_emperors_armor_01";
		this.m.SpriteDamagedBack = "bust_named_emperors_armor_01_damaged";
		this.m.SpriteCorpseBack = "bust_named_emperors_armor_01_dead";
		this.m.Icon = "legend_armor/icon_named_emperors_armor_01.png";
		this.m.IconLarge = "legend_armor/inventory_named_emperors_armor_01.png";
		this.m.OverlayIcon = "legend_armor/icon_named_emperors_armor_01.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_named_emperors_armor_01.png";
	}

});

