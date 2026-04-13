::mods_hookExactClass("skills/perks/perk_brawny", function(o) {
	o.onUpdate <- function ( _properties )
	{
		_properties.Stamina += this.getContainer().getActor().getBaseProperties().Stamina * 0.25;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if (_properties.IsProficientWithHeavyWeapons)
			return;

		local weapons = this.getContainer().getActor().getItems().getAllItems().filter(@(idx, item) item.isItemType(this.Const.Items.ItemType.Weapon) && item.getSkills().len() != 0);
		foreach (weapon in weapons)
		{
			if (weapon != null && weapon.m.FatigueOnSkillUse > 0)
			{
				foreach (skill in weapon.getSkills())
				{
					skill.m.FatigueCost -= 1;
				}
			}
		}
	}
});