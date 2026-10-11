::mods_hookExactClass("items/accessory/bandage_item", function (o) {
	o.m.OriginalValue <- null;
	o.m.OriginalDescription <- null;
	o.m.Ammo <- 1;
	o.m.AmmoMax <- 1;
	o.m.AmmoCost <- 5;
	o.m.AmmoType <- "Medicine";
	o.m.ShowArmamentIcon <- true;

	local create = o.create;
	o.create = function () {
		create();
		this.m.OriginalDescription = this.m.Description;
		this.m.OriginalValue = this.m.Value;
		this.m.StaminaModifier = -3;
		this.m.ItemType = ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Tool;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local result = getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ammo.png",
			text = "Costs [color=%negative%]" + this.m.AmmoCost + "[/color] Medicine to refill"
		});
		return result;
	}

	o.consumeAmmo <- function () {
		this.m.AmmoCost = 0;
		this.setAmmo(::Math.max(0, this.m.Ammo - 1));
		if (this.getContainer().getActor().isPlayerControlled()) {
			::Tactical.Entities.spendAmmo(this.m.AmmoCost);
		}
		this.m.AmmoCost = 5;
	}

	o.isAmountShown <- function () {
		return true;
	}

	o.getAmountString <- function () {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.getAmmo <- function () {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function () {
		return this.m.AmmoMax;
	}

	o.getAmmoCost <- function () {
		return this.m.AmmoCost;
	}

	o.setAmmo <- function (_a) {
		this.m.Ammo = _a;

		if (this.m.Ammo > 0) {
			this.m.Name = "Bandage";
			this.m.ShowArmamentIcon = true;
			this.m.Description = this.m.OriginalDescription;
			this.m.Value = this.m.OriginalValue;
		} else {
			this.m.Name = "Bandage (Used)";
			this.m.ShowArmamentIcon = false;
			this.m.Description = "A spent bandage bale.";
			this.m.Value = 0;
		}

		this.updateAppearance();
	}

	o.getAmmoType <- function () {
		return this.m.AmmoType;
	}
});
