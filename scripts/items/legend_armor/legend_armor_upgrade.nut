this.legend_armor_upgrade <- this.inherit("scripts/items/item", {
	m = {
		OverlayIcon = "",
		OverlayIconLarge = "",
		SpriteFront = null,
		SpriteBack = null,
		SpriteDamagedFront = null,
		SpriteDamagedBack = null,
		SpriteCorpseFront = null,
		SpriteCorpseBack = null,
		ArmorDescription = "",
		Armor = null,		// Base-Armor that this piece is currently attached to
		Type = -1,
		ImpactSound = this.Const.Sound.ArmorLeatherImpact,
		InventorySound = this.Const.Sound.ArmorLeatherImpact,
		IsDestroyedOnRemove = false,
		Variants = [],

		// Basic stats on armor items
		Condition = 1.0,
		ConditionMax = 1.0,
		ConditionModifier = 0,	// [Legacy] - This does not do anything. It should be removed on the next major version jump
		StaminaModifier = 0,	// Stamina Cost. A negative value is bad and the default for items.

		// Common effects across all upgrades handled by this base class
		DirectDamageModifier = 0.0,	// %-Value. Modifies the HP damage taken from attacks hitting body armor
		InitiativeModifier = 0,		// Modifies Initiative of wearer
		ThreatModifier = 0,		// Modifies Threat of wearer (The inverse of this is subtracted from Resolve of adjacent enemies)
		ResolveModifier = 0,		// Modifies Resolve of wearer
		DamageReceivedArmorMult = 0.0,		// Multiplier to the damage received by the currently worn body armor
		FatiguePenaltyMultiplier = 0.0,		// The Fatigue cost of the currently equipped body armor is increased or reduced by this value as a fraction
		Visible = true,
	},
	function create()
	{
		this.item.create();
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ItemType = this.Const.Items.ItemType.Armor;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
	}

	function isAmountShown()
	{
		return this.m.Condition != this.m.ConditionMax;
	}

	function getAmountString()
	{
		return "" + this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * 100) + "%";
	}

	function getAmountColor()
	{
		if (this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1)) > 4)
		{
			return 4;
		}

		return this.Const.Items.ConditionColor[this.Math.max(0, this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1)))];
	}

	function getValue()
	{
		return this.Math.floor(this.m.Value * (1.0 * this.m.Condition / (1.0 * this.m.ConditionMax)));
	}

	function getType()
	{
		return this.m.Type;
	}

	function getOverlayIcon()
	{
		return this.m.OverlayIcon;
	}

	function getOverlayIconLarge()
	{
		return this.m.OverlayIconLarge;
	}

	function isUsed()
	{
		return this.m.Armor != null;
	}

	function isDestroyedOnRemove()
	{
		return this.m.IsDestroyedOnRemove;
	}

	function getArmor()
	{
		return this.m.Armor;
	}

	function setArmor( _a )
	{
		this.m.Armor = _a == null ? null : this.WeakTableRef(_a);
	}

	function getArmorDescription()
	{
		return this.m.ArmorDescription;
	}

	function getStaminaModifier()
	{
		if (this.getContainer() == null)
			return this.m.StaminaModifier;

		if (this.getContainer().getActor() == null)
			return this.m.StaminaModifier;

		local perk = ::Legends.Perks.get(this, ::Legends.Perk.LegendFashionable);
		if (perk != null && ::Legends.S.oneOf(this.m.Type, perk.m.FreeSlotTypes))
			return 0;

		return this.m.StaminaModifier;
	}

	function getDirectDamageModifier()
	{
		if (this.m.DirectDamageModifier >= 0) return this.m.DirectDamageModifier;
		if (this.m.Armor == null || this.m.Armor.getContainer() == null || !this.m.Armor.isEquipped()) return this.m.DirectDamageModifier;
		local percentageRemainingArmor = this.Math.floor(this.m.Armor.getArmor() * 100.0 / this.m.Armor.getArmorMax());
		return -1 * this.Math.min(percentageRemainingArmor, this.Math.abs(this.m.DirectDamageModifier));
	}

	function getInitiativeModifier()
	{
		return this.m.InitiativeModifier;
	}

	function getThreatModifier()
	{
		return this.m.ThreatModifier;
	}

	function getResolveModifier()
	{
		return this.m.ResolveModifier;
	}

	function getDamageReceivedArmorMult()
	{
		return this.m.DamageReceivedArmorMult;
	}

	function getFatiguePenaltyMultiplier()
	{
		return this.m.FatiguePenaltyMultiplier;
	}

	function getCurrentFatigueModifier()	// a positive value is good and is added to the available stamina of the character
	{
		if (this.m.Armor == null || this.m.Armor.getContainer() == null) return 0.0;
		return -1 * this.Math.floor(this.Math.abs(this.m.Armor.getStaminaModifier()) / 100.0 * getFatiguePenaltyMultiplier());
	}

	function getIconOverlay()
	{
		local L = [];
		if (this.isNamed()) {
			if (this.isItemType(::Const.Items.ItemType.Legendary))
				L.push("layers/legendary_icon_glow.png");
			else
				L.push("layers/named_icon_glow.png");
		}

		L.push(this.m.Icon);

		switch (this.m.Type)
		{
			case this.Const.Items.ArmorUpgrades.Chain:
				L.push("layers/layer_1.png");
				break;
			case this.Const.Items.ArmorUpgrades.Plate:
				L.push("layers/layer_2.png");
				break;
			case this.Const.Items.ArmorUpgrades.Tabard:
				L.push("layers/layer_3.png");
				break;
			case this.Const.Items.ArmorUpgrades.Cloak:
				L.push("layers/layer_4.png");
				break;
			case this.Const.Items.ArmorUpgrades.Attachment:
				L.push("layers/layer_5.png");
				break;
		}

		if (L.len() == 0)
			return [""];

		return L;
	}

	function getIconLargeOverlay()
	{
		return this.getIconOverlay();
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
				text = getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_body.png",
			value = this.getCondition(),
			valueMax = this.getConditionMax(),
			text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
			style = "armor-body-slim"
		});

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue Weight Penalty: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + this.Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
			});
		}

		if ( this.getStaminaModifier() < 0 && ::Legends.Mod.ModSettings.getSetting("ShowArmorPerFatigueValue").getValue() )
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = format("(%.1f Armor per 1 Weight)", this.getConditionMax() / (1.0 * this.Math.abs(this.getStaminaModifier())))
			});
		}

		// Other common stats found on Attachements:
		this.applyEffectTooltips(result);
		if (this.getOverlayIconLarge() != null && this.m.Type != this.Const.Items.ArmorUpgrades.Rune)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getOverlayIconLarge(),
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

		// Interaction Tooltips
		if (this.m.Armor == null) {
			result.push({
				id = 70,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Right-click or left-click and drag onto the armor of the currently selected character to attach."
			});
			result.push({
				id = 71,
				type = "hint",
				icon = "ui/icons/mouse_left_button_shift.png",
				text = "Hold Shift and drag onto an armor in the stash to attach."
			});
		} else {
			result.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button_shift.png",
				text = "Hold Left-Shift and Left-Click this layer square to toggle it hidden on this character (stats & other benefits will not be affected)."
			});
			result.push({
				id = 2,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Unequip layer"
			});
		}

		local rune = ::Legends.Runes.get(this.getRuneVariant());
		if (rune != null) {
			result.push({
				id = 77,
				type = "text",
				icon = "ui/icons/special.png",
				text = rune.getTooltip(this)
			});
		}

		return result;
	}

	function getArmorTooltip( _result )
	{
		_result.push({	// An empty line is put in to improve formatting
			id = 10,
			type = "text",
			text = "&nbsp;"
		});

		_result.push({
				id = 10,
				type = "text",
				text = "[b][u]%name%[/u][/b]",
				icon = "ui/items/" + this.m.Icon,
				param = [["name", this.getName()]],
				isPartialLayer = true
			});

		if ( ::Legends.Mod.ModSettings.getSetting("ShowExpandedArmorLayerTooltip").getValue() )
		{
			_result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Armor: " + this.getConditionMax()
			});

			if ( this.getStaminaModifier() != 0 ) {
				_result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Fatigue Weight Penalty: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + this.Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
				});
			}

			local rune = ::Legends.Runes.get(this.getRuneVariant());
			if (rune != null) {
				_result.push({
					id = 77,
					type = "text",
					icon = "ui/icons/special.png",
					text = rune.getTooltip(this)
				});
			}
		}
		this.onArmorTooltip(_result);
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.InventorySound[this.Math.rand(0, this.m.InventorySound.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function addArmor( _a)
	{
		if (_a + this.m.Condition <= this.m.ConditionMax)
		{
			this.m.Condition += _a;
			return 0
		}

		local ret = _a - (this.m.ConditionMax - this.m.Condition);
		this.m.Condition = this.m.ConditionMax;
		return ret;
	}

	function removeArmor( _a)
	{
		if (this.m.Condition - _a >= 0)
		{
			this.m.Condition -= _a;
			return 0
		}
		local delta = _a - this.m.Condition;
		this.m.Condition = 0;
		return delta;
	}

	function onRepair( _a)
	{
		this.setCondition(_a);
	}

	function setCondition( _a )
	{
		if (this.m.Condition <= _a)
		{
			this.addArmor(_a - this.m.Condition);
		}
		else
		{
			this.removeArmor(this.m.Condition - _a)
		}

		if (this.m.Armor == null)
		{
			return
		}

		if (this.m.Armor.getContainer() != null && this.m.Armor.isEquipped())
		{
			local app = this.m.Armor.getContainer().getAppearance();
			this.updateAppearance(app);
		}
	}

	function getContainer()
	{
		return this.m.Armor == null ? this.item.getContainer() : this.m.Armor.getContainer();
	}

	function getRepair()
	{
		return this.Math.floor(this.getCondition());
	}

	function getRepairMax()
	{
		return this.Math.floor(this.getConditionMax());
	}

	function toggleVisible()
	{
		return this.setVisible(!this.isVisible());
	}

	function setVisible(_bool)
	{
		this.m.Visible = _bool;
		if (this.m.Armor != null && this.m.Armor.getContainer() != null && this.m.Armor.isEquipped())
		{
			local app = this.getContainer().getAppearance();
			this.updateAppearance(app);
			this.getContainer().updateAppearance();
		}
		return _bool
	}

	function isVisible()
	{
		return this.m.Visible;
	}

	function updateAppearance( _app )
	{
		local frontSprite = "";
		local backSprite = "";
		local frontSpriteCorpse = this.m.SpriteCorpseFront != null ? this.m.SpriteCorpseFront : "";
		local backSpriteCorpse = this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
		if (this.isVisible() == false)
		{
			frontSprite = "";
			backSprite = "";
			frontSpriteCorpse = "";
			backSpriteCorpse = "";
		}
		else if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		{
			frontSprite = this.m.SpriteDamagedFront != null ? this.m.SpriteDamagedFront : this.m.SpriteFront != null ? this.m.SpriteFront : "";
			backSprite = this.m.SpriteDamagedBack != null ? this.m.SpriteDamagedBack : this.m.SpriteBack != null ? this.m.SpriteBack : "";
		}
		else
		{
			frontSprite = this.m.SpriteFront != null ? this.m.SpriteFront : "";
			backSprite = this.m.SpriteBack != null ? this.m.SpriteBack : "";
		}

		if (_app == null)
		{
			return;
		}

		local key = "";
		local prefix = "ArmorLayer";
		
		switch(this.m.Type) {
			case this.Const.Items.ArmorUpgrades.Chain:      key = "Chain"; break;
			case this.Const.Items.ArmorUpgrades.Plate:      key = "Plate"; break;
			case this.Const.Items.ArmorUpgrades.Tabard:    key = "Tabard"; break;
			case this.Const.Items.ArmorUpgrades.Cloak:      key = "Cloak"; break;
			case this.Const.Items.ArmorUpgrades.Attachment: key = "Upgrade"; prefix = "Armor"; break; 
		}

		if (key != "") {
			local hasFrontSprite = (key == "Cloak" || key == "Upgrade");
			local p = prefix + key;
			local s = hasFrontSprite ? "Back" : "";

			if (hasFrontSprite) {
				_app[p + "Front"] = frontSprite;
				_app["Corpse" + p + "Front"] = frontSpriteCorpse;
			}

			_app[p + s] = backSprite;
			_app["Corpse" + p + s] = backSpriteCorpse;
		}
	}

	function onEquip()
	{
		this.item.onEquip();
		this.setCurrentSlotType(this.m.SlotType);
	}

	function onUnequip()
	{
		this.item.onUnequip();
		//if (::Legends.Mod.ModSettings.getSetting("AutoRepairLayer").getValue() && this.getCondition() != this.getConditionMax()) this.setToBeRepaired(true, 0);
		this.setCurrentSlotType(this.Const.ItemSlot.None);
	}

	function onUse( _actor, _item = null, _playSound = true )
	{
		if (this.isUsed()) return false;

		local armor = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body) : _item;

		if (armor == null) return false;

		local success = armor.setUpgrade(this);

		if (success && _playSound)
		{
			this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
		}

		return success;
	}

	function onUpdateProperties(_properties)
	{
		if (this.getInitiativeModifier() != 0) _properties.Initiative += this.getInitiativeModifier();
		if (this.getThreatModifier() != 0) _properties.Threat += this.getThreatModifier();
		if (this.getResolveModifier() != 0) _properties.Bravery += this.getResolveModifier();
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.getDirectDamageModifier() != 0) _properties.DamageReceivedDirectMult *= 1.0 + (this.getDirectDamageModifier() / 100.0);
		if (this.getDamageReceivedArmorMult() != 0) _properties.DamageReceivedArmorMult *= 1.0 + (this.getDamageReceivedArmorMult() / 100.0);
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		if (_damage >= this.m.Condition)
		{
			local leftoverDamage = _damage - this.m.Condition;
			this.m.Condition = 0.0;
			return leftoverDamage;
		}

		this.m.Condition = this.Math.max(0, this.m.Condition - _damage) * 1.0;
		return 0.0;
	}

	function onArmorTooltip( _result )
	{
		this.applyEffectTooltips(_result);
	}

	function applyEffectTooltips( _tooltipList )
	{
		if (this.getInitiativeModifier() != 0)
		{
			_tooltipList.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Legends.S.colorize("" + ::Legends.S.getSign(this.getInitiativeModifier()) + this.Math.abs(this.getInitiativeModifier()), this.getInitiativeModifier()) + " Initiative"
			});
		}

		if (this.getThreatModifier() != 0)
		{
			local invertedThreat = -1 * this.getThreatModifier();	// For this tooltip we want to show the actual effect on the enemy
			_tooltipList.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.String.capitalizeFirst(::Legends.S.getChangingWord(invertedThreat)) + " the Resolve of any opponent engaged in melee by " +
					 ::Legends.S.colorize("" + ::Legends.S.getSign(invertedThreat) + this.Math.abs(invertedThreat), invertedThreat)
			});
		}
		if (this.getResolveModifier() != 0)
		{
			_tooltipList.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Legends.S.colorize("" + ::Legends.S.getSign(this.getResolveModifier()) + this.Math.abs(this.getResolveModifier()), this.getResolveModifier()) + " Resolve"
			});
		}
		if (this.getDirectDamageModifier() != 0)
		{
			_tooltipList.push({
				id = 15,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = ::MSU.String.capitalizeFirst(::Legends.S.getChangingWord(this.getDirectDamageModifier())) + " damage ignoring armor by " +
					::Legends.S.colorize("" + ::Legends.S.getSign(this.getDirectDamageModifier()) + this.Math.abs(this.getDirectDamageModifier()) + "%", this.getDirectDamageModifier())
			});
		}
		if ("BraveryMult" in this.m) {
			_tooltipList.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Increase the Resolve of the wearer by [color=%positive%]+" + ::Math.round(this.m.BraveryMult * 100.0 - 100) + "%[/color]"
			});
		}
		if (this.getDamageReceivedArmorMult() != 0)
		{
			_tooltipList.push({
				id = 16,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Body Armor damage taken is " + ::Legends.S.getChangingWord(getDamageReceivedArmorMult()) + "d by " +
				::Legends.S.colorize("" + ::Legends.S.getSign(this.getDamageReceivedArmorMult()) + this.Math.abs(this.getDamageReceivedArmorMult()) + "%", this.getDamageReceivedArmorMult())
			});
		}
		if (this.getFatiguePenaltyMultiplier() != 0)
		{
			_tooltipList.push({
				id = 17,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue penalty of wearing body armor is " + ::Legends.S.getChangingWord(getFatiguePenaltyMultiplier()) + "d by " +
				::Legends.S.colorize("" + ::Legends.S.getSign(this.getFatiguePenaltyMultiplier()) + this.Math.abs(this.getFatiguePenaltyMultiplier()) + "%", this.getFatiguePenaltyMultiplier())
			});
		}
		if (this.getCurrentFatigueModifier() != 0)
		{
			_tooltipList.push({
				id = 17,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue Weight Penalty " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getCurrentFatigueModifier()) + this.Math.abs(this.getCurrentFatigueModifier()), this.getCurrentFatigueModifier())
			});
		}
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeBool(this.m.Visible);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Visible = _in.readBool();
	}
});
