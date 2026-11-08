::mods_hookExactClass("items/tools/reinforced_throwing_net", function (o) {
	o.m.OriginalDescription <- "";
	o.m.OriginalValue <- 0;
	o.m.OwnerID <- null;
	o.m.OriginalAmmoCost <- 0;
	o.m.AllowsOffhandActions <- false;

	o.isAmountShown <- function () {
		return true;
	}

	o.getAmountString <- function () {
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	o.isDroppedAsLoot <- function () {
		return this.item.isDroppedAsLoot();
	}

	o.getAmmoCost <- function () {
		return ::World.Statistics.getFlags().get("LegendsCanRepairNet") ? 10 : this.m.OriginalAmmoCost;
	}

	local create = o.create;
	o.create = function () {
		create();
		this.m.OriginalValue = this.m.Value;
		this.m.OriginalDescription = this.m.Description;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Ammo | ::Const.Items.ItemType.Net;
		this.m.OriginalAmmoCost = 15;
		this.m.AmmoCost = this.m.OriginalAmmoCost;
		this.m.AmmoMax = 1;
		this.m.Ammo = 1;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local result = getTooltip();

		for (local i = result.len() - 1; i >= 0; --i) {
			if (result[i].type == "text" && result[i].id == 8) {
				result[i].text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]";
			}

			if (result[i].type == "text" && result[i].text == "Is destroyed on use") {
				result.remove(i);
			}
		}

		if (this.allowsOffhandActions()) {
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Doesn't prevent Double Gripping or unarmed followups"
			});
		}

		if (this.m.Ammo <= 0) {
			result.push({
				id = 11,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Is broken and useless[/color]"
			});
		}

		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Requires " + (::World.Statistics.getFlags().get("LegendsCanRepairNet") ? 10 : 15) + " Ammo to repair after battle"
		});

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

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ThrowNet) && ::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendNetCasting)) {
			_skill.m.MaxRange = 5;
		}

		this.weapon.addSkill(_skill);
	}

	o.onUpdateProperties <- function (_properties) {
		this.weapon.onUpdateProperties(_properties);
		// Net Repair Perk negates the weight
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendNetRepair)) {
			_properties.Stamina -= this.m.StaminaModifier;
		}
	}

	// Bag fatigue uses getStaminaModifier
	o.getStaminaModifier <- function () {
		return ((::Legends.S.isNull(this.getContainer()) || ::Legends.S.isNull(this.getContainer().getActor()) || !::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendNetRepair)) ? this.m.StaminaModifier : 0);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		this.m.OwnerID = this.getContainer().getActor().getID();
	}

	o.setAmmo <- function (_a) {
		this.weapon.setAmmo(_a);
		this.updateAmmo();
	}

	o.consumeAmmo <- function () {
		this.m.AmmoCost = 0;
		this.weapon.consumeAmmo(); // to prevent scavenger retinue from recover ammo part
		this.m.AmmoCost = this.m.OriginalAmmoCost;
	}

	o.updateAmmo <- function () {
		if (this.m.Ammo > 0) {
			this.m.Name = "Reinforced Throwing Net";
			this.m.Description = this.m.OriginalDescription;
			this.m.IconLarge = "tools/inventory_throwing_net_02.png";
			this.m.Icon = "tools/throwing_net_02_70x70.png";
			this.m.ShowArmamentIcon = true;
			this.m.Value = this.m.OriginalValue;
		} else {
			this.m.Name = "Broken Throwing Net";
			this.m.Description = "A broken net that may be repaired if you have the supplies, or sold for scrap.";
			this.m.IconLarge = "tools/inventory_throwing_net_broken.png";
			this.m.Icon = "tools/throwing_net_broken_70x70.png";
			this.m.ShowArmamentIcon = false;
			this.m.Value = 0;
		}

		this.updateAppearance();
	}

	o.allowsOffhandActions <- @() this.getContainer() != null && this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;

	o.onDeserialize <- function (_in) {
		this.weapon.onDeserialize(_in);
		this.updateAmmo();
	}
});
