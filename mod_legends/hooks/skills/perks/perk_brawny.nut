::mods_hookExactClass("skills/perks/perk_brawny", function (o) {
	o.m.StaminaModifier <- 0.25;

	o.onUpdate <- function (_properties) {
		_properties.Stamina += this.getContainer().getActor().getBaseProperties().Stamina * this.m.StaminaModifier;
	}

	o.onAfterUpdate <- function (_properties) {
		if (_properties.IsProficientWithHeavyWeapons) {
			return;
		}

		local weapons = this.getContainer().getActor().getItems().getAllItems().filter(@(idx, item) item.isItemType(::Const.Items.ItemType.Weapon) && item.getSkills().len() != 0);
		foreach (weapon in weapons) {
			if (weapon != null && weapon.m.FatigueOnSkillUse > 0) {
				foreach (skill in weapon.getSkills()) {
					skill.m.FatigueCost -= 1;
				}
			}
		}
	}
});
