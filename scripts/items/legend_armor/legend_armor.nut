this.legend_armor <- this.inherit("scripts/items/armor/armor", {
	m = {
		Upgrades = null,
		Variants = [],
		Blocked = [],
		Type = -1
	},
	function create()
	{
		this.armor.create();
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.Upgrades = [];

		for (local i = 0; i < this.Const.Items.ArmorUpgrades.COUNT; i = ++i)
		{
			this.m.Upgrades.push(null);
			this.m.Blocked.push(false);
		}
	}

	function isArmorNamed()
	{
		if (this.isNamed()) {
			return true;
		}

		foreach (u in this.m.Upgrades)
		{
			if (u != null && u.isNamed())
			{
				return true;
			}
		}

		return false
	}

	function isBought()
	{
		foreach (u in this.m.Upgrades)
		{
			if (u != null && u.isBought() == false)
			{
				return false;
			}
		}

		return this.m.IsBought;
	}

	function getIcon()
	{
		if (this.isArmorNamed())
		{
			return "layers/named_icon_glow.png"
		}
		return this.m.Icon;
	}


	function getIconOverlay()
	{
		local L = [];

		if (this.isArmorNamed())
		{
			L.push(this.m.Icon);
		}

		foreach (u in this.m.Upgrades)
		{
			if (u != null)
			{
				L.push(u.getOverlayIcon());
			}
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

		return L;
	}

	function getIconLarge()
	{
		if (this.isArmorNamed()) {
			return "layers/named_inventory_glow.png"
		}

		return this.m.IconLarge != "" ? this.m.IconLarge : null;
	}

	function getIconLargeOverlay()
	{
		local L = [];

		if (this.isArmorNamed())
		{
			L.push(this.m.IconLarge);
		}

		foreach (u in this.m.Upgrades)
		{
			if (u != null)
			{
				L.push(u.getOverlayIconLarge());
			}
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

		return L;
	}

	function blockUpgrades()
	{
		for( local i = 0; i < this.Const.Items.ArmorUpgrades.COUNT; i = ++i )
		{
			this.m.Blocked[i] = true;
		}
	}

	function getAddedValue(_function, _base, _all = false)
	{
		local value = _base;

		foreach (i, upgrade in this.m.Upgrades)
		{
			if (upgrade != null)
			{
				value += upgrade[_function]();
			}
		}

		return value;
	}

	function getRepair()
	{
		return this.Math.floor(this.getAddedValue("getCondition", this.m.Condition));
	}

	function getRepairMax()
	{
		return this.Math.floor(this.getAddedValue("getConditionMax", this.m.ConditionMax));
	}

	function getArmor()
	{
		return this.getAddedValue("getCondition", this.m.Condition);
	}

	function getArmorMax()
	{
		return this.getAddedValue("getConditionMax", this.m.ConditionMax);
	}

	function getStaminaModifier()
	{
		return this.getAddedValue("getStaminaModifier", this.m.StaminaModifier);
	}

	function getValue()
	{
		return this.Math.floor(this.getAddedValue("getValue", this.m.Value * (1.0 * this.m.Condition / (1.0 * this.m.ConditionMax))));
	}

	function getRawValue()
	{
		return this.getAddedValue("getRawValue", this.m.Value);
	}

	function doOnFunction(_function, _argsArray = null)
	{
		if (_argsArray == null) _argsArray = [];
		_argsArray.insert(0, null);

		foreach (u in this.m.Upgrades)
		{
			if (u != null)
			{
				_argsArray[0] = u;
				u[_function].acall(_argsArray);
			}
		}
	}

	function setBought( _bought )
	{
		this.armor.setBought(_bought);
		this.doOnFunction("setBought", [_bought]);
	}

	function setSold( _sold )
	{
		this.armor.setSold(_sold);
		this.doOnFunction("setSold", [_sold]);
	}

	function onTurnStart()
	{
		this.doOnFunction("onTurnStart");
	}

	function onUse( _skill )
	{
		this.doOnFunction("onUse", [_skill]);
	}

	function onTotalArmorChanged()
	{
		this.doOnFunction("onTotalArmorChanged");
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.doOnFunction("onBeforeDamageReceived", [_attacker, _skill, _hitInfo, _properties]);
	}

	function onCombatStarted()
	{
		this.doOnFunction("onCombatStarted");
	}

	function onCombatFinished()
	{
		this.doOnFunction("onCombatFinished");
	}

	function onActorDied( _onTile )
	{
		this.doOnFunction("onActorDied", [_onTile]);
	}

	function setCurrentSlotType( _slotType )
	{
		this.m.CurrentSlotType = _slotType;
		this.doOnFunction("setCurrentSlotType", [_slotType]);
	}

	function clearSkills()
	{
		this.item.clearSkills();
		this.doOnFunction("clearSkills");
	}

	function addArmor( _a )
	{
		if (_a + this.m.Condition <= this.m.ConditionMax)
		{
			this.m.Condition += _a;
			return;
		}

		this.m.Condition = this.m.ConditionMax;
		local delta = _a - (this.m.ConditionMax - this.m.Condition);

		foreach (u in this.m.Upgrades)
		{
			if (u != null)
			{
				delta = u.addArmor(delta);

				if (delta <= 0) break;
			}
		}
	}

	function removeArmor( _a)
	{
		local delta = _a;
		for (local i = this.Const.Items.ArmorUpgrades.COUNT - 1; i >= 0; i = --i)
		{
			if (this.m.Upgrades[i] != null)
			{
				delta = this.m.Upgrades[i].removeArmor(delta);

				if (delta <= 0) break;
			}
		}

		if (delta > 0)
		{
			this.m.Condition = this.Math.maxf(0, this.m.Condition - delta);
		}
	}

	function setArmor( _a )
	{
		this.setCondition( _a)
	}

	function onRepair( _a)
	{
		this.setArmor(_a);
		return 0;
	}

	function setCondition( _a )
	{
		local oldValue = this.getArmor();
		//Adding armor
		if (oldValue <= _a)
		{
			this.addArmor(_a - oldValue);
		}
		else
		{
			this.removeArmor(oldValue - _a)
		}

		this.updateAppearance();
	}

	function isAmountShown()
	{
		return this.getArmor() != this.getArmorMax();
	}

	function getAmountString()
	{
		return "" + this.Math.floor(this.getArmor() / (this.getArmorMax() * 1.0) * 100) + "%";
	}

	function getAmountColor()
	{
		return this.Const.Items.ConditionColor[this.Math.min(this.Const.Items.ConditionColor.len() - 1, this.Math.max(0, this.Math.floor(this.getArmor() / (this.getArmorMax() * 1.0) * (this.Const.Items.ConditionColor.len() - 1))))];
	}

	function upgradeIsBlocked( _slot )
	{
		return this.m.Blocked[_slot];
	}

	function getUpgrade( _slot = -1 )
	{
		if (_slot != -1)
		{
			return this.m.Upgrades[_slot];
		}

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				return u;
			}
		}

		return null;
	}

	function getUpgrades()
	{
		local slots = [];

		foreach( i, u in this.m.Upgrades )
		{
			if (this.m.Blocked[i])
			{
				slots.push(-1);
			}
			else if (u == null)
			{
				slots.push(0);
			}
			else if (!u.isVisible())
			{
				slots.push(2);
			}
			else
			{
				slots.push(1);
			}
		}

		return slots;
	}

	function getUpgradeIDs()
	{
		local ids = [];
		foreach (i, u in this.m.Upgrades)
		{
			if (this.m.Blocked[i] || u == null)
			{
				ids.push(null);
			}
			else
			{
				ids.push(u.getID());
			}
		}
		return ids;
	}

	function getUpgradesNamed() {

		foreach(u in this.m.Upgrades)
		{
			if (u != null && u.isNamed())
			{
				return u.getName();
			}
		}

		return ""
	}

	function setUpgrade( _upgrade )
	{
		if (_upgrade == null) return true;
		if (_upgrade != null && this.m.Blocked[_upgrade.getType()]) return false;

		local oldIndex;


		if ("Assets" in this.World && this.World.Assets.getStash())
		{

			oldIndex = this.World.Assets.getStash().getItemByInstanceID(_upgrade.getInstanceID())

		}

		if (oldIndex != null) oldIndex = oldIndex.index;

		local oldItem;
		if (this.m.Upgrades[_upgrade.getType()] != null)
		{
			oldItem = this.removeUpgrade(_upgrade.getType());
		}
		this.m.Upgrades[_upgrade.getType()] = _upgrade;
		_upgrade.setArmor(this);
		_upgrade.setVisible(true);

		if (this.m.Container != null)
		{
			_upgrade.onEquip();
			this.getContainer().getActor().getSkills().update();
		}

		//switch places with other upgrade item
		local result = {
			item = null,
			index = oldIndex
		}
		if (oldItem != null && !oldItem.isDestroyedOnRemove())
		{
			result.item = oldItem;
		}

		this.updateAppearance();
		return result;
	}

	function removeUpgrade( _slot )
	{
		if (this.m.Upgrades[_slot] == null || this.Stash.getNumberOfEmptySlots() == 0) return null;

		local app = this.getContainer() == null ? null : this.getContainer().getAppearance();
		local item = this.m.Upgrades[_slot];
		item.onUnequip();
		item.setVisible(true);
		item.setArmor(null);

		this.m.Upgrades[_slot] = null;
		if (this.m.Container != null) this.getContainer().getActor().getSkills().update();

		this.updateAppearance();
		return item;
	}

	function makeName()
	{
		local NAME = this.getName();

		local uname = this.getUpgradesNamed();

		if (uname != "") {
			NAME = uname + " " + this.getName();
		}
		else if (this.getUpgrade(1) != null)
		{
			NAME = this.getUpgrade(1).getName() + " on " + this.getName();

			if (this.getUpgrade(0) != null)
			{
				NAME = this.getUpgrade(1).getName() + " on " + this.getUpgrade(0).getName();
			}
		}
		else if (this.getUpgrade(0) != null)
		{
			NAME = this.getUpgrade(0).getName() + " on " + this.getName();
		}

		if (this.getUpgrade(5) != null)
		{
			NAME = "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]" + NAME;
		}

		return NAME;
	}

	function getTooltip()
	{
		local description = this.getDescription();

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				description += " " + u.getArmorDescription();
			}
		}

		local result = [
			{
				id = 1,
				type = "title",
				text = this.makeName()
			},
			{
				id = 2,
				type = "description",
				text = description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		result.push({
			id = 3,
			type = "image",
			image = this.m.IconLarge != "" ? this.m.IconLarge : this.m.Icon,
			isLarge = this.m.IconLarge != "" ? true : false
		});


		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				if (u.getIconLarge() != null)
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIconLarge(),
						isLarge = true
					});
				}
				else
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIcon()
					});
				}
			}
		}

		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_body.png",
			value = this.Math.floor(this.getArmor()),
			valueMax = this.Math.floor(this.getArmorMax()),
			text = "" + this.Math.floor(this.getArmor()) + " / " + this.Math.floor(this.getArmorMax()) + "",
			style = "armor-body-slim"
		});

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + this.Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
			});
		}

		if (this.getStaminaModifier() < 0 && ::Legends.Mod.ModSettings.getSetting("ShowArmorPerFatigueValue").getValue() )
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = format("(%.1f Armor per 1 Weight)", this.getArmorMax() / (1.0 * this.Math.abs(this.getStaminaModifier())))
			});
		}

		local upgradeNum = this.m.Upgrades.filter(@(idx, val) val != null).len();
		if ( upgradeNum > 0 && ::Legends.Mod.ModSettings.getSetting("ShowExpandedArmorLayerTooltip").getValue() )
		{
			result.push({	// An empty line is put in to improve formatting
				id = 10,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[u]" + this.getName() + "[/u]"
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Armor: " + this.m.ConditionMax
			});
			if ( this.m.StaminaModifier != 0 )
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.m.StaminaModifier) + this.Math.abs(this.m.StaminaModifier), this.m.StaminaModifier)
				});
			}
		}

		this.doOnFunction("getArmorTooltip", [result]);

		if (this.isRuned())
		{
			result.push({	// An empty line is put in to improve formatting
				id = 20,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		if (upgradeNum > 0){
			result.push({
				id = 65,
				type = "hint",
				icon = "ui/icons/mouse_right_button_shift.png",
				text = "Shift + Right-click to remove all layers."
			});
		}

		return result;
	}

	function isDroppedAsLoot()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		if (this.isArmorNamed())
		{
			return true;
		}

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local repair = this.getRepair();
		local repairMax = this.getRepairMax();
		local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsBlacksmithed;

		if (repair > 10 && isPlayer)
		{
			return true;
		}

		if (repair > 10 && repair / repairMax >= 0.2)
		{
			return true;
		}

		if (isLucky)
		{
			return true;
		}

		if (isBlacksmithed)
		{
			return true;
		}

		return false;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.InventorySound[this.Math.rand(0, this.m.InventorySound.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_body_" + variant;
		this.m.SpriteDamaged = "bust_body_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_body_" + variant + "_dead";
		this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

	function updateAppearance()
	{
		if (this.getContainer() == null || !this.isEquipped())
		{
			return;
		}

		if (!this.m.ShowOnCharacter)
		{
			return;
		}

		this.clearAppearance();
		local app = this.getContainer().getAppearance();
		app.CorpseArmor = this.m.SpriteCorpse;
		app.HideBody = this.m.HideBody;
		local sound = this.m.ImpactSound;

		if (this.m.Upgrades[this.Const.Items.ArmorUpgrades.Plate] != null)
		{
			sound = this.m.Upgrades[this.Const.Items.ArmorUpgrades.Plate].m.ImpactSound;
		}
		else if (this.m.Upgrades[this.Const.Items.ArmorUpgrades.Chain] != null)
		{
			sound = this.m.Upgrades[this.Const.Items.ArmorUpgrades.Chain].m.ImpactSound;
		}

		app.ImpactSound[this.Const.BodyPart.Body] = sound;

		if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		{
			if (this.m.SpriteDamaged != null)
			{
				app.Armor = this.m.SpriteDamaged;
			}
		}
		else if (this.m.Sprite != null)
		{
			app.Armor = this.m.Sprite;
		}

		foreach (u in this.m.Upgrades)
		{
			if (u != null) u.updateAppearance(app);
		}

		this.doOnFunction("updateAppearance", [app]);

		this.getContainer().updateAppearance();
	}

	function clearAppearance()
	{
		local app = this.getContainer().getAppearance();
		app.Armor = "";
		app.ArmorLayerChain = "";
		app.ArmorLayerPlate = "";
		app.ArmorLayerTabbard = "";
		app.ArmorLayerCloakFront = "";
		app.ArmorLayerCloakBack = "";
		app.ArmorUpgradeFront = "";
		app.ArmorUpgradeBack = "";
		app.CorpseArmor = "";
		app.CorpseArmorLayerChain = "";
		app.CorpseArmorLayerPlate = "";
		app.CorpseArmorLayerTabbard = "";
		app.CorpseArmorLayerCloakFront = "";
		app.CorpseArmorLayerCloakBack = "";
		app.CorpseArmorUpgradeFront = "";
		app.CorpseArmorUpgradeBack = "";
		app.HideBody = false;
		app.ImpactSound[this.Const.BodyPart.Body] = [];
	}

	function onEquip()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		this.updateAppearance();
		this.doOnFunction("onEquip");
	}

	function onUnequip()
	{
		this.doOnFunction("onUnequip");

		if (this.m.ShowOnCharacter)
		{
			this.clearAppearance();
			this.getContainer().updateAppearance();

			if (this.getContainer().getActor() != null && !this.getContainer().getActor().isNull())
			{
				this.getContainer().getActor().resetBloodied();
			}
		}

		this.item.onUnequip();
	}



	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		local totalDamage = _damage;

		for( local i = this.Const.Items.ArmorUpgrades.COUNT - 1; i >= 0; i = --i )
		{
			local u = this.m.Upgrades[i];

			if (u == null)
			{
			}
			else
			{
				totalDamage = u.onDamageReceived(totalDamage, _fatalityType, _attacker);
			}
		}

		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}

		this.m.Condition = this.Math.max(0, this.m.Condition - totalDamage) * 1.0;

		if (this.m.Condition == 0 && !this.m.IsIndestructible)
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.makeName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage and has been destroyed!");
			if (_attacker != null && _attacker.isPlayerControlled())
			{
				this.Tactical.Entities.addArmorParts(this.getArmorMax());
			}
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.makeName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage");
		}
		this.updateAppearance();
	}

	function onUpdateProperties( _properties )
	{
		if (this.getContainer() == null)
		{
			return;
		}

		if (this.getContainer().getActor() == null)
		{
			return;
		}

		local staminaMult = 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.brawny"))
		{
			staminaMult = 0.70;
		}

		_properties.Armor[this.Const.BodyPart.Body] += this.getArmor();
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.getArmorMax();
		_properties.Stamina += this.Math.ceil(this.getStaminaModifier() * staminaMult);

		this.doOnFunction("onUpdateProperties", [_properties]);
	}



	function isItemType( _t )
	{
		if (_t == this.Const.Items.ItemType.Named || _t == this.Const.Items.ItemType.Legendary)
		{
			if ((this.m.ItemType & _t) != 0)
			{
				return true
			}

			foreach( u in this.m.Upgrades )
			{
				if (u != null && u.isItemType(_t))
				{
					return true
				}
			}
			return false
		}

		return (this.m.ItemType & _t) != 0;
	}

	function setupArmor(_variant)
	{
	}

	function onSerialize( _out )
	{
		this.armor.onSerialize(_out);
		_out.writeU8(this.m.Upgrades.len());

		foreach (i, upgrade in this.m.Upgrades)
		{
			if (upgrade == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeI32(upgrade.ClassNameHash);
				upgrade.onSerialize(_out);
			}
		}
	}

	function onDeserialize( _in )
	{
		this.armor.onDeserialize(_in);
		local count = _in.readU8();
		this.m.Upgrades = [];

		for( local i = 0; i < count; i = ++i )
		{
			this.m.Upgrades.push(null);

			if (_in.readBool()) //has item
			{
				local item = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
				item.onDeserialize(_in);
				this.m.Upgrades[i] = item;
				this.m.Upgrades[i].setArmor(this);
			}
		}
	}
});

