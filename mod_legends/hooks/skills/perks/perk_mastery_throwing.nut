::mods_hookExactClass("skills/perks/perk_mastery_throwing", function(o) {
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged())
			return;

		local weapon = _skill.getItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			return;

		local actor = this.getContainer().getActor();
		_properties.DamageDirectAdd += 0.002 * _properties.getRangedSkill();
		_properties.DamageArmorMult += 0.0025 * _properties.getMeleeSkill();
	}
});
