::mods_hookExactClass("skills/effects/berserker_rage_effect", function(o) {
	
	o.getDescription = function ()
	{
		return "The smell of blood and death sends you into an uncontrollable rage. Getting attacked, hitting your enemies and every kill you make embolderns you and increases your lethality. Once in a rage, you must continuously feed it to keep it going";
	}

	o.onTurnStart = function ()
	{
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 3);
		this.getContainer().getActor().updateRageVisuals(this.m.RageStacks);
	}

	o.onUpdate = function (_properties)
	{
		if this.m.RageStacks >= 40;
			this.m.RageStacks = 40;
		this.m.IsHidden = this.m.RageStacks == 0;
		_properties.DamageReceivedTotalMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
		_properties.Bravery += 1 * this.m.RageStacks;
		_properties.DamageTotalMult *= 1.0 + this.m.RageStacks * 0.01;
		_properties.Initiative += 1 * this.m.RageStacks;
	}

	o.onBeingAttacked <- function ( _attacker, _skill, _properties )
	{
		this.addRage(1);
	}

	o.onDamageReceived <- function ( _attacker, _damageHitpoints, _damageArmor )
	{
		this.addRage(2);
	}

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.addRage(1);
	}

	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		this.addRage(2);
	}
});