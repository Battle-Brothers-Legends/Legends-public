::mods_hookExactClass("skills/perks/perk_taunt", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.Taunt);
	}

	o.onAnySkillUsed <- function (_skill, _targetEntity, _properties) {
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction()) {
			_properties.MeleeSkillMult *= 0.5;
			_properties.RangedSkillMult *= 0.5;
		}
	}
});
