::mods_hookExactClass("skills/actives/gash_skill", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = 10;
	}

	o.getTooltip = function () {
		return this.getDefaultTooltip();
	}

	o.getHitChanceModifier = function () {
		return 10;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			this.m.HitChanceBonus += _properties.IsSpecializedInSwords ? 5 : 0;
			_properties.ThresholdToInflictInjuryMult *= _properties.IsSpecializedInSwords ? 0.5 : 0.66;
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}

	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo ) {
		if (_skill == this) {
			if (_targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding) {
				::Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}
});
