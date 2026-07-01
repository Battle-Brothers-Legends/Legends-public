::mods_hookExactClass("skills/effects/berserker_rage_effect", function(o) {
	o.m.IsBerserker <- false;
	o.getDescription = function () {
		return "The scent of blood and carnage drives this character into a primal frenzy. The rage demands constant slaughter to maintain. Every blow sustained, strike delivered, and life claimed fuels the growing bloodlust, drastically enhancing combat prowess.";
	}

	o.onUpdate = function ( _properties )
	{
		this.m.IsHidden = this.m.RageStacks == 0;
		_properties.Bravery += 1 * this.m.RageStacks;
		_properties.DamageRegularMin += 1 * this.m.RageStacks;
		_properties.DamageRegularMax += 1 * this.m.RageStacks;
		_properties.Initiative += 1 * this.m.RageStacks;
	}

	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) {
			return;
		}

		_properties.DamageReceivedRegularMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
	}

	o.onTurnStart = function () {
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 2);
		this.getContainer().getActor().updateRageVisuals(this.m.RageStacks);
	}
	
	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		if (this.m.RageStacks >= 50)
			this.m.RageStacks = 50;
		onUpdate( _properties );
	}

	o.onDamageReceived <- function ( _attacker, _damageHitpoints, _damageArmor ) {
		this.addRage(1);
		if (this.m.IsBerserker) {
			this.addRage(2);
		}
	}

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		this.addRage(1);
		if (this.m.IsBerserker) {
			this.addRage(2);
		}
	}

	o.onTargetKilled = function ( _targetEntity, _skill ) {
		this.addRage(2);
		if (this.m.IsBerserker) {
			this.addRage(3);
		}
	}
});