::mods_hookExactClass("items/accessory/spider_poison_item", function (o) {
	o.m.OriginalValue <- null;
	o.m.OriginalDescription <- null;
	o.m.Ammo <- null;
	o.m.AmmoMax <- null;
	o.m.AmmoCost <- null;
	o.m.ShowArmamentIcon <- true;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "A flask of oil laced with concentrated webknecht poison. Can be used to coat your weapons and arrowtips.";
		this.m.OriginalDescription = this.m.Description;
		this.m.OriginalValue = this.m.Value;
		this.m.ItemType = ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Tool;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 20;
	}

	o.getTooltip = function () {
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

	o.consumeAmmo <- function () {
		this.m.AmmoCost = 0;
		this.setAmmo(::Math.max(0, this.m.Ammo - 1));
		if (this.getContainer().getActor().isPlayerControlled()) {
			::Tactical.Entities.spendAmmo(this.m.AmmoCost);
		}
		this.m.AmmoCost = 20;
	}

	o.isAmountShown <- function () {
		return true;
	}

	o.getAmountString <- function () {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.getAmmo <- function () {
		return this.m.Ammo == 0	&& ::World.Assets.m.ProfessionEffect.LegendAlchemy <= 0	? this.m.AmmoMax + 1: this.m.Ammo;
	}

	o.getAmmoMax <- function () {
		return this.m.AmmoMax;
	}

	o.setAmmo <- function (_a) {
		this.m.Ammo = _a;

		if (this.m.Ammo > 0) {
			this.m.Name = "Poisoned Oil";
			this.m.ShowArmamentIcon = true;
			this.m.Description = this.m.OriginalDescription;
			this.m.Value = this.m.OriginalValue;
		} else {
			this.m.Name = "Poisoned Oil (Used)";
			this.m.ShowArmamentIcon = false;
			this.m.Description = "A spent spider poison vial.";
			this.m.Value = 0;
		}

		this.updateAppearance();
	}
});
