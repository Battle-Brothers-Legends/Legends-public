this.legend_redback_poison_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		OriginalValue = null,
		OriginalDescription = null,
		Ammo = null,
		AmmoMax = null,
		AmmoCost = null,
		ShowArmamentIcon = true
	},

	function create() {
		this.accessory.create();
		this.m.ID = "accessory.legend_redback_poison";
		this.m.Name = "Redback Poison";
		this.m.Description = "A flask of redback spider poison used. Can be used to coat your weapons and arrowtips.";
		this.m.SlotType = ::Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_04.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 500;
		this.m.OriginalValue = this.m.Value;
		this.m.OriginalDescription = this.m.Description;
		this.m.ItemType = ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Tool;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 20;
		this.m.ShowArmamentIcon <- true;
	}

	function getTooltip() {
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

		if (this.getIconLarge() != null) {
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		} else {
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}
		result.extend([
			{
				id = 66,
				type = "text",
				text = this.getValueString()
			}
		]);
		if (::World.Assets.m.ProfessionEffect.LegendAlchemy <= 0) {
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be refilled after battle, because the company has no one specializing in Alchemy"
			});
		}
		return result;
	}

	function playInventorySound(_eventType) {
		::Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function consumeAmmo () {
		this.m.AmmoCost = 0;
		this.setAmmo(::Math.max(0, this.m.Ammo - 1));
		if (this.getContainer().getActor().isPlayerControlled()) {
			::Tactical.Entities.spendAmmo(this.m.AmmoCost);
		}
		this.m.AmmoCost = 20;
	}

	function isAmountShown () {
		return true;
	}

	function getAmountString () {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function getAmmo () {
		return this.m.Ammo == 0	&& ::World.Assets.m.ProfessionEffect.LegendAlchemy <= 0	? this.m.AmmoMax + 1: this.m.Ammo;
	}

	function getAmmoMax () {
		return this.m.AmmoMax;
	}

	function setAmmo (_a) {
		this.m.Ammo = _a;

		if (this.m.Ammo > 0) {
			this.m.Name = "Redback Poison";
			this.m.ShowArmamentIcon = true;
			this.m.Description = this.m.OriginalDescription;
			this.m.Value = this.m.OriginalValue;
		} else {
			this.m.Name = "Redback Poison (Used)";
			this.m.ShowArmamentIcon = false;
			this.m.Description = "A spent poison vial.";
			this.m.Value = 0;
		}

		this.updateAppearance();
	}

	function onEquip() {
		this.accessory.onEquip();
		local skill = ::Legends.Actives.new(::Legends.Active.LegendCoatWithRedbackPoison);
		skill.setItem(this);
		this.addSkill(skill);
	}

	function onPutIntoBag() {
		this.onEquip();
	}
});

