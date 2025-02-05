this.legend_helmet_upgrade <- this.inherit("scripts/items/item", {
	m = {
		OverlayIcon = "",
		OverlayIconLarge = "",
		Sprite = null,
		SpriteDamaged = null,
		SpriteCorpse = null,
		ArmorDescription = "",
		Armor = null,
		ConditionModifier = 0,
		StaminaModifier = 0,
		Type = -1,
		IsLowerVanity = false,
		ImpactSound = this.Const.Sound.ArmorLeatherImpact,
		InventorySound = this.Const.Sound.ArmorLeatherImpact,
		IsDestroyedOnRemove = false,
		Variants = [],
		HideHair = false,
		HideBeard = false,
		Vision = 0,
		Visible = true
	},
	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.Head;
		this.m.ItemType = this.Const.Items.ItemType.Helmet;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_helmet_" + variant;
		this.m.SpriteDamaged = "bust_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_helmet_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_helmet_" + variant + ".png";
	}

	function getVision()
	{
		return this.m.Vision;
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

	function getContainer()
	{
		return this.m.Armor == null ? null : this.m.Armor.getContainer();
	}

	function getArmorDescription()
	{
		return this.m.ArmorDescription;
	}

	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
	}

	function getIconOverlay()
	{
		local L = [];

		if (this.isNamed())
		{
			L.push("layers/named_icon_glow.png");
		}

		L.push(this.m.Icon);

		switch (this.m.Type)
		{
			case this.Const.Items.HelmetUpgrades.Helm:
				L.push("layers/layer_1.png");
				break;
			case this.Const.Items.HelmetUpgrades.Top:
				L.push("layers/layer_2.png");
				break;
			case this.Const.Items.HelmetUpgrades.Vanity:
				L.push("layers/layer_3.png");
				break;
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

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

		if (this.getOverlayIconLarge() != null)
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

		result.push({
			id = 65,
			type = "hint",
			icon = "ui/icons/mouse_right_button.png",
			text = "Right-click or left-click and drag onto the helmet of the currently selected character to attach."
		});
		result.push({
			id = 66,
			type = "hint",
			icon = "ui/icons/mouse_right_button_shift_drag.png",
			text = "Hold Shift and drag onto a helmet in the stash to attach."
		});
		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_head.png",
			value = this.getCondition(),
			valueMax = this.getConditionMax(),
			text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
			style = "armor-head-slim"
		});

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + this.Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
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

		if (this.getVision() != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getVision()) + this.Math.abs(this.getVision()), this.getVision())
			});
		}

		return result;
	}

	function getArmorTooltip( _result, _isExtraVanity )
	{
		_result.push({	// An empty line is put in to improve formatting
			id = 10,
			type = "text",
			icon = "ui/icons/blank.png",
			text = " "
		});
		_result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/armor_head.png",	// ui/icons/armor_body.png
			text = "[u]" + this.getName() + "[/u]"
		});

		if ( ::Legends.Mod.ModSettings.getSetting("ShowExpandedArmorLayerTooltip").getValue() )
		{
			if ( _isExtraVanity )
			{
				_result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/blank.png",
					text = "(Cosmetic only)"
				});
			} else {
				_result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/armor_head.png",
					text = "Armor: " + this.getConditionMax()
				});
				if ( this.getStaminaModifier() != 0 )
				{
					_result.push({
						id = 10,
						type = "text",
						icon = "ui/icons/fatigue.png",
						text = "Fatigue: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + this.Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
					});
				}
			}
		}

		if (this.getVision() != 0)
		{
			_result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getVision()) + this.Math.abs(this.getVision()), this.getVision())
			});
		}
		this.onArmorTooltip(_result);
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.ImpactSound[0], this.Const.Sound.Volume.Inventory);
	}

	function addArmor( _a)
	{
		if (_a + this.m.Condition <= this.m.ConditionMax)
		{
			this.m.Condition += _a;
			return 0;
		}

		this.m.Condition = this.m.ConditionMax;
		return _a - (this.m.ConditionMax - this.m.Condition);
	}

	function removeArmor( _a)
	{
		if (this.m.Condition - _a >= 0)
		{
			this.m.Condition -= _a;
			return 0;
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
		if (_a >= this.m.Condition)
		{
			this.addArmor(_a - this.m.Condition);
		}
		else
		{
			this.removeArmor(this.m.Condition - _a);
		}

		if (this.m.Armor == null)
		{
			return;
		}

		if (this.m.Armor.getContainer() != null && this.m.Armor.isEquipped())
		{
			local app = this.m.Armor.getContainer().getAppearance();
			this.updateAppearance(app);
		}
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
		return _bool;
	}

	function isVisible()
	{
		return this.m.Visible;
	}

	function updateAppearance( _app )
	{
		if (_app == null)
		{
			return false;
		}
		local sprite = "";
		local slot = this.m.Type;
		if (slot == this.Const.Items.HelmetUpgrades.Vanity && this.m.Armor.getUpgrade(slot) != this)
		{
			slot = this.Const.Items.HelmetUpgrades.ExtraVanity;
		}

		if (this.isVisible() == false)
		{
			sprite = "";
		}
		else if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		{
			sprite = this.m.SpriteDamaged != null ? this.m.SpriteDamaged : "";
		}
		else
		{
			sprite = this.m.Sprite != null ? this.m.Sprite : "";
		}

		switch(slot)
		{
			case this.Const.Items.HelmetUpgrades.Helm:
				_app.HelmetLayerHelm = sprite;
				_app.HelmetLayerHelmCorpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
				break;

			case this.Const.Items.HelmetUpgrades.Top:
				_app.HelmetLayerTop = sprite;
				_app.HelmetLayerTopCorpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
				break;

			case this.Const.Items.HelmetUpgrades.Vanity:
				if (this.m.IsLowerVanity)
				{
					_app.HelmetLayerVanity = "";
					_app.HelmetLayerVanityCorpse = "";
					_app.HelmetLayerVanityLower = sprite;
					_app.HelmetLayerVanityLowerCorpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
				}
				else
				{
					_app.HelmetLayerVanity = sprite;
					_app.HelmetLayerVanityCorpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
					_app.HelmetLayerVanityLower = "";
					_app.HelmetLayerVanityLowerCorpse = "";
				}
				break;

			case this.Const.Items.HelmetUpgrades.ExtraVanity:
				if (this.m.IsLowerVanity)
				{
					_app.HelmetLayerVanity2 = "";
					_app.HelmetLayerVanity2Corpse = "";
					_app.HelmetLayerVanity2Lower = sprite;
					_app.HelmetLayerVanity2LowerCorpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
				}
				else
				{
					_app.HelmetLayerVanity2 = sprite;
					_app.HelmetLayerVanity2Corpse = this.m.SpriteCorpse != null ? this.m.SpriteCorpse : "";
					_app.HelmetLayerVanity2Lower = "";
					_app.HelmetLayerVanity2LowerCorpse = "";
				}
		}

		return true;

	}

	function onEquip()
	{
		this.item.onEquip();
		this.setCurrentSlotType(this.m.SlotType);
	}

	function onUnequip()
	{
		this.item.onUnequip();
        if (::Legends.Mod.ModSettings.getSetting("AutoRepairLayer").getValue() && this.getCondition() != this.getConditionMax()) this.setToBeRepaired(true, 0);
		this.setCurrentSlotType(this.Const.ItemSlot.None);
	}

	function onUse( _actor, _item = null )
	{
		if (this.isUsed()) return false;

		local armor = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head) : _item;
		if (armor == null) return false;

		local success = armor.setUpgrade(this);

		if (success)
		{
			this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
		}

		return success;
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

