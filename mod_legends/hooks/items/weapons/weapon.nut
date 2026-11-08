::mods_hookExactClass("items/weapons/weapon", function (o) {
	o.m.Variants <- [];
	o.m.PossibleEffectIdx <- -1;

	o.getShieldDamage = function () {
		if (this.getContainer() == null || this.getContainer().getActor() == null) {
			return this.m.ShieldDamage;
		}
		local perk = ::Legends.Perks.get(this, ::Legends.Perk.LegendSmashingShields);
		local shieldDamage = perk == null ? this.m.ShieldDamage : this.m.ShieldDamage * perk.getModifier();
		return ::Math.floor(this.getContainer().getActor().canDoubleGrip() ? shieldDamage * 1.25 : shieldDamage);
	}

	local onDamageDealt = o.onDamageDealt;
	o.onDamageDealt = function (_target, _skill, _hitInfo) {
		if (_skill.m.IsExecutingOffhand) {
			_skill.m.IsExecutingOffhand = false;
		}

		// Both mainhand and offhand weapons are called for every hit, so we have to check
		// which weapon actually executed the skill to avoid doubling durability loss.
		local item = _skill.m.Item;
		if (item != null && !item.isNull() && item.getInstanceID() != this.getInstanceID()) {
			return;
		}
		onDamageDealt(_target, _skill, _hitInfo);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local result = getTooltip();
		if (this.isRuned()) {
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
			result.push({
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When scrapped, rune will be refunded"
			});
		}

		foreach (tooltip in result) {
			if (!tooltip.rawin("id") || !tooltip.rawin("text") || !tooltip.rawin("icon")) {
				continue;
			}

			if (tooltip.id == 8 && tooltip.icon == "ui/icons/fatigue.png" && tooltip.text.find("skills build up") == null) {
				tooltip.text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]";
			}
		}

		if (!this.isItemType(::Const.Items.ItemType.Ammo) && this.m.AmmoMax > 0) {
			foreach (tooltip in result) {
				if (("text" in tooltip) && typeof tooltip.text == "string") {
					if (tooltip.text.find("Is empty and useless") != null) {
						tooltip.text = "[color=%negative%]Has no spare ammunition[/color]";
						break;
					}
				}
			}
		}

		if (this.m.PossibleEffectIdx != -1) {
			result.push({
				id = 12,
				type = "text",
				icon = this.m.EffectTooltip.Icon
				text = this.m.EffectTooltip.Text(this)
			});
		}

		local grantedSkills = this.getGrantedSkills();
		foreach (skill in grantedSkills) {
			result.push({
				id = 23,
				type = "text",
				icon = skill.m.Icon,
				text = skill.getName() + (skill.isActive() ? " (" + skill.m.ActionPointCost + ::Legends.Text.inlineIcons("action_points") + ", " + skill.m.FatigueCost + ::Legends.Text.inlineIcons("fatigue") + ")" : "")
			});
		}

		return result;
	}

	o.getIconOverlay <- function () {
		if (this.isRuned()) {
			return ["layers/glow_runed_icon.png"];
		}
		return [""];

	}

	o.getIconLargeOverlay <- function () {
		if (this.isRuned()) {
			return ["layers/glow_runed_inventory.png"];
		}
		return [""];
	}

	o.isDroppedAsLoot = function () {
		if (!this.item.isDroppedAsLoot()) {
			return false;
		}

		if (this.isNamed()) {
			return true;
		}

		local isPlayer = this.m.LastEquippedByFaction == ::Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !::Tactical.State.isScenarioMode() && !isPlayer && ::World.Assets.getOrigin().isDroppedAsLoot(this);
		local isBlacksmithed = isPlayer && !::Tactical.State.isScenarioMode() && ::World.Assets.m.ProfessionEffect.LegendMaterialist > 0;
		return (!this.item.isItemType(::Const.Items.ItemType.Ammo) || isPlayer || this.m.Ammo > 0 && this.getCurrentSlotType() != ::Const.ItemSlot.Bag || this.m.Ammo > 0 && this.m.Ammo < this.m.AmmoMax && this.getCurrentSlotType() == ::Const.ItemSlot.Bag) && (this.m.Condition >= 12 || this.m.ConditionMax <= 1 || isLucky || isBlacksmithed) && (isPlayer || isLucky || ::Math.rand(1, 100) <= 90);
	}

	o.updateAppearance = function () {
		if (!this.isEquipped()) {
			return;
		}

		local changed = false;

		local currentSlot = this.getCurrentSlotType();
		local appearance = this.getContainer().getAppearance();
		if (this.m.ShowArmamentIcon) {
			if (currentSlot == ::Const.ItemSlot.Offhand) {
				changed = appearance.Shield != this.m.ArmamentIcon;
				appearance.Shield = this.m.ArmamentIcon;
			} else {
				changed = appearance.Weapon != this.m.ArmamentIcon;
				appearance.Weapon = this.m.ArmamentIcon;
				appearance.TwoHanded = this.m.BlockedSlotType != null;
			}
		} else {
			if (currentSlot == ::Const.ItemSlot.Offhand) {
				changed = appearance.Shield != "";
				appearance.Shield = "";
			} else {
				changed = appearance.Weapon != "";
				appearance.Weapon = "";
				appearance.TwoHanded = false;
			}
		}

		if (changed) {
			this.getContainer().updateAppearance();
		}
	}

	o.onEquip = function () {
		this.item.onEquip();

		if (this.m.AddGenericSkill) {
			this.addGenericItemSkill();
		}

		this.updateAppearance();

		if (this.getContainer().getActor().isSummoned()) {
			return;
		}

		if (this.m.Condition == this.m.ConditionMax && !this.isKindOf(this.getContainer().getActor().get(), "player")) {
			this.m.Condition = ::Math.rand(1, ::Math.max(1, this.m.ConditionMax - 2)) * 1.0;
		}
	}

	o.onUnequip = function () {
		local currentSlot = this.getCurrentSlotType();
		local appearance = this.getContainer().getAppearance();

		this.m.IsBloodied = false;
		this.item.onUnequip();

		if (this.m.ShowArmamentIcon) {
			if (currentSlot == ::Const.ItemSlot.Offhand) {
				appearance.Shield = "";
			} else {
				appearance.Weapon = "";
				appearance.TwoHanded = false;
			}
		}

		this.getContainer().updateAppearance();
	}

	o.setBloodied = function (_isBloodied) {
		if (_isBloodied == this.m.IsBloodied) {
			return;
		}

		this.m.IsBloodied = _isBloodied;

		if (this.m.ShowArmamentIcon) {
			local currentSlot = this.getCurrentSlotType();
			local brushName = _isBloodied && this.doesBrushExist(this.m.ArmamentIcon + "_bloodied") ? this.m.ArmamentIcon + "_bloodied" : this.m.ArmamentIcon;

			local appearance = this.getContainer().getAppearance();
			if (currentSlot == ::Const.ItemSlot.Offhand) {
				appearance.Shield = brushName;
			} else {
				appearance.Weapon = brushName;
			}

			this.getContainer().updateAppearance();
		}
	}

	o.onUpdateProperties = function (_properties) {
		_properties.Stamina += this.m.StaminaModifier;

		if (this.getCurrentSlotType() == ::Const.ItemSlot.Mainhand) {
			_properties.DamageRegularMin += this.m.RegularDamage;
			_properties.DamageRegularMax += this.m.RegularDamageMax;
			_properties.DamageArmorMult *= this.m.ArmorDamageMult;
			_properties.DamageDirectAdd += this.m.DirectDamageAdd;
			_properties.HitChance[::Const.BodyPart.Head] += this.m.ChanceToHitHead;
		}
	}

	o.updateRuneSigil <- function () {
		this.item.updateRuneSigil();
		// return
		// if (this.m.ArmamentIcon.find("runed_") != null)
		// {
		// 	return;
		// }
		// this.m.ArmamentIcon = "runed_" + this.m.ArmamentIcon;
	}

	o.getGrantedSkills <- function () {
		local skillsGranted = [];
		local dummy = ::World.getTemporaryRoster().create("scripts/entity/tactical/human");
		local dummyItem = ::new(::IO.scriptFilenameByHash(this.ClassNameHash));
		dummyItem.weapon.addSkill = function (_skill) {
			_skill.setItem(dummyItem);
			if (!_skill.m.IsHidden) {
				skillsGranted.push(_skill);
			}
		};
		dummyItem.weapon.onEquip = @() {};
		dummyItem.setContainer(dummy.getItems());
		dummyItem.onEquip();
		::World.getTemporaryRoster().clear();
		return skillsGranted;
	}

	o.allowsOffhandActions <- @() this.m.AllowsOffhandActions;

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function (_in) {
		onDeserialize(_in);
		if (this.isRuned()) {
			this.updateRuneSigil();
		}
	}
});
