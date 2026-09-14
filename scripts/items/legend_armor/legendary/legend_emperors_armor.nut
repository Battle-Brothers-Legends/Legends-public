this.legend_emperors_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "armor.body.legend_emperors_armor";
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.Name = "The Emperor\'s Armor";
		this.m.Description = "A shining armor once worn by the emperor of an age long past, made from the most wondrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.ArmorDescription = "Includes a shining armor made from the most wondrous of materials.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 20000;
		this.m.Condition = 350;
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -35;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "armor_emperors_named_" + variant;
		this.m.SpriteDamagedBack = "armor_emperors_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "armor_emperors_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_armor_emperors_named_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_armor_emperors_named_" + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_armor_emperors_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_armor_emperors_named_" + variant + ".png";
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
					::Legends.Effects.grant(a, ::Legends.Effect.Dazed);
			}
		}
	}
});

