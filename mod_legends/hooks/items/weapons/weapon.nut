::mods_hookExactClass("items/weapons/weapon", function(o) {
	o.m.Variants <- [];

	o.getShieldDamage = function ()
	{
		if (this.getContainer() == null || this.getContainer().getActor() == null)
		{
			return this.m.ShieldDamage;
		}
		local perk = ::Legends.Perks.get(this, ::Legends.Perk.LegendSmashingShields);

		return perk == null ? this.m.ShieldDamage : this.Math.round(this.m.ShieldDamage * perk.getModifier());
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

	o.onUpdateProperties = function ( _properties )
	{
		_properties.Stamina += this.m.StaminaModifier;

		if (this.m.SlotType == this.Const.ItemSlot.Mainhand)
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
