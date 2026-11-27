::mods_hookExactClass("skills/actives/gash_skill", function(o)
{
	o.getTooltip = function () {
		return this.getDefaultTooltip();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.ThresholdToInflictInjuryMult *= _properties.IsSpecializedInSwords ? 0.5 : 0.66;
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
