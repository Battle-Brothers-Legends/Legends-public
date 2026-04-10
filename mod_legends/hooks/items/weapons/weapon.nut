::mods_hookExactClass("items/weapons/weapon", function(o) {
	o.m.Variants <- [];

	o.getShieldDamage = function ()
	{
		if (this.getContainer() == null || this.getContainer().getActor() == null)
		{
			return this.m.ShieldDamage;
		}
		local perk = ::Legends.Perks.get(this, ::Legends.Perk.LegendSmashingShields);
		local doubleGrip = ::Legends.Effects.has(this, ::Legends.Effect.DoubleGrip) && ::Legends.Effects.get(this, ::Legends.Effect.DoubleGrip).canDoubleGrip() ? true : false;
		local shieldDamage = perk == null ? this.m.ShieldDamage : this.m.ShieldDamage * perk.getModifier();
		return doubleGrip ? this.Math.floor(shieldDamage * 1.25) : this.Math.floor(shieldDamage);
	}

	local onDamageDealt = o.onDamageDealt;
	o.onDamageDealt = function ( _target, _skill, _hitInfo )
	{
		if (_skill.m.IsExecutingOffhand) {
			_skill.m.IsExecutingOffhand = false;
			return;
		}

		onDamageDealt( _target, _skill, _hitInfo );
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		if (this.isRuned())
		{
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

		if (!this.isItemType(::Const.Items.ItemType.Ammo) && this.m.AmmoMax > 0) {
			foreach (tooltip in result) {
				if (("text" in tooltip) && typeof tooltip.text == "string") {
					if (tooltip.text.find("Is empty and useless") != null) {
						tooltip.text = "[color=" + ::Const.UI.Color.NegativeValue + "]Has no spare ammunition[/color]";
						break;
					}
				}
			}
		}

		return result;
	}

	o.getIconOverlay <- function ()
	{
		if (this.isRuned()) {
			return ["layers/glow_runed_icon.png"];
		}
		return  [""];

	}

	o.getIconLargeOverlay <- function ()
	{
		if (this.isRuned()) {
			return ["layers/glow_runed_inventory.png"];
		}
		return  [""];

	}

	o.isDroppedAsLoot = function ()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		if (this.isNamed())
		{
			return true;
		}

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && !isPlayer && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsBlacksmithed;
		return (this.m.AmmoMax == 0 || isPlayer || this.m.Ammo > 0 && this.getCurrentSlotType() != this.Const.ItemSlot.Bag || this.m.Ammo > 0 && this.m.Ammo < this.m.AmmoMax && this.getCurrentSlotType() == this.Const.ItemSlot.Bag) && (this.m.Condition >= 12 || this.m.ConditionMax <= 1 || isLucky || isBlacksmithed) && (isPlayer || isLucky || this.Math.rand(1, 100) <= 90);
	}

	o.updateAppearance = function () {
		if (!this.isEquipped()) {
			return;
		}

		local changed = false;

		local currentSlot = this.getCurrentSlotType();
		local appearance = this.getContainer().getAppearance();
		if (this.m.ShowArmamentIcon) {
			if (currentSlot == this.Const.ItemSlot.Offhand) {
				changed = appearance.Shield != this.m.ArmamentIcon;
				appearance.Shield = this.m.ArmamentIcon;
			} else {
				changed = appearance.Weapon != this.m.ArmamentIcon;
				appearance.Weapon = this.m.ArmamentIcon;
				appearance.TwoHanded = this.m.BlockedSlotType != null;
			}
		} else {
			if (currentSlot == this.Const.ItemSlot.Offhand) {
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

	o.onEquip = function ()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		this.updateAppearance();

		if (this.getContainer().getActor().isSummoned())
		{
			return;
		}

		if (this.m.Condition == this.m.ConditionMax && !this.isKindOf(this.getContainer().getActor().get(), "player"))
		{
			this.m.Condition = this.Math.rand(1, this.Math.max(1, this.m.ConditionMax - 2)) * 1.0;
		}
	}

	o.onUnequip = function () {
		local currentSlot = this.getCurrentSlotType();
		local appearance = this.getContainer().getAppearance();

		this.m.IsBloodied = false;
		this.item.onUnequip();

		if (this.m.ShowArmamentIcon) {
			if (currentSlot == this.Const.ItemSlot.Offhand) {
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
			local brushName = _isBloodied
				&& this.doesBrushExist(this.m.ArmamentIcon + "_bloodied")
				? this.m.ArmamentIcon + "_bloodied"
				: this.m.ArmamentIcon;

			local appearance = this.getContainer().getAppearance();
			if (currentSlot == this.Const.ItemSlot.Offhand) {
				appearance.Shield = brushName;
			} else {
				appearance.Weapon = brushName;
			}

			this.getContainer().updateAppearance();
		}
	}

	o.onUpdateProperties = function ( _properties )
	{
		_properties.Stamina += this.m.StaminaModifier;

		if (this.getCurrentSlotType() == this.Const.ItemSlot.Mainhand)
		{
			_properties.DamageRegularMin += this.m.RegularDamage;
			_properties.DamageRegularMax += this.m.RegularDamageMax;
			_properties.DamageArmorMult *= this.m.ArmorDamageMult;
			_properties.DamageDirectAdd += this.m.DirectDamageAdd;
			_properties.HitChance[this.Const.BodyPart.Head] += this.m.ChanceToHitHead;
		}
	}

	o.updateRuneSigil <- function ()
	{
		this.item.updateRuneSigil();
		// return
		// if (this.m.ArmamentIcon.find("runed_") != null)
		// {
		// 	return;
		// }
		// this.m.ArmamentIcon = "runed_" + this.m.ArmamentIcon;
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}
});
