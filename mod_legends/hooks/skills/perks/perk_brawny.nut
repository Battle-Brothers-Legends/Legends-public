::mods_hookExactClass("skills/perks/perk_brawny", function (o) {
	o.m.StaminaModifier <- 0.25;

	o.onUpdate <- function (_properties) {
		_properties.Stamina += this.getContainer().getActor().getBaseProperties().Stamina * this.m.StaminaModifier;
	}

	o.onAfterUpdate <- function (_properties) {
		if (_properties.IsProficientWithHeavyWeapons) {
			return;
		}

		local actor = this.getContainer().getActor();
		foreach (weapon in [actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand), actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand)].filter(@(_, _item)(_item != null && _item.isItemType(::Const.Items.ItemType.Weapon) && _item.m.FatigueOnSkillUse > 0))) {
			foreach (skill in actor.getSkills().queryActives().filter(@(_, _skill)(_skill.getItem() != null && _skill.getItem().get() == weapon))) {
				skill.m.FatigueCost -= 1;
			}
		}
	}
});
