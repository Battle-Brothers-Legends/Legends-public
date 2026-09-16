this.legend_emperors_armor_fake <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.emperors_armor";
		this.m.Name = "The Emperor\'s Armor";
		this.m.Description = "A shining armor once worn by the emperor of an age long past, made from the most woundrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.IsIndestructible = true;
		this.m.Variant = 80;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 20000;
		this.m.Condition = 380;
		this.m.ConditionMax = 380;
		this.m.StaminaModifier = -30;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
		this.blockUpgrades();
		this.m.Blocked[ ::Const.Items.ArmorUpgrades.Attachment] = false
	}

	function isDroppedAsLoot()
	{
		return this.m.IsDroppedAsLoot;
	}

	function getTooltip()
	{
		local result = this.legend_armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reflects [color=%positive%]25%[/color] of damage taken in melee back to the attacker"
		});
		return result;
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		this.legend_armor.onDamageReceived(_damage, _fatalityType, _attacker);

		if (_attacker != null && _attacker.isAlive() && _attacker.getHitpoints() > 0 && _attacker.getID() != this.getContainer().getActor().getID() && _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1 && !_attacker.getCurrentProperties().IsImmuneToDamageReflection)
		{
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = ::Math.maxf(1.0, _damage * 0.25);
			hitInfo.DamageArmor = ::Math.maxf(1.0, _damage * 0.25);
			hitInfo.DamageDirect = 0.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_attacker.onDamageReceived(_attacker, null, hitInfo);
		}
	}

	// function drop( _tile = null )
	// {
	// 	this.m.IsDroppedAsLoot = false;

	// 	if (this.getContainer() != null)
	// 	{
	// 		if (_tile == null && this.getContainer().getActor() != null && this.getContainer().getActor().isPlacedOnMap())
	// 			_tile = this.getContainer().getActor().getTile();

	// 		this.getContainer().unequip(this);
	// 	}

	// 	if (::Tactical.State.getStrategicProperties() != null && ::Tactical.State.getStrategicProperties().IsArenaMode)
	// 		return false;

	// 	if (_tile == null)
	// 	{
	// 		if (::Tactical.State.getStrategicProperties() == null)
	// 		{
	// 			this.logWarning("Attempted to drop item, but no tile specified!");
	// 			return false;
	// 		}

	// 		::Tactical.State.getStrategicProperties().Loot.add("scripts/items/legend_armor/legendary/legend_emperors_armor");
	// 		return true;
	// 	}

	// 	local real = this.new("scripts/items/legend_armor/legendary/legend_emperors_armor");
	// 	real.setCondition(::Math.maxf(this.getCondition(), ::Math.minf(1.0, this.getConditionMax())));
	// 	_tile.Items.push(real);
	// 	_tile.IsContainingItems = true;
	// 	real.m.Tile = _tile;
	// 	real.onDrop(_tile);
	// 	return true;
	// }

});

