::mods_hookExactClass("skills/effects/berserker_rage_effect", function(o) {
	
	o.getDescription = function ()
	{
		return "The smell of blood and death sends you into an uncontrollable rage. Every taste of blood your weapon takes and every kill you make embolderns you and increases your lethality. Once in a rage, you must continuously feed it to keep it going";
	}

	o.onTurnStart = function ()
	{
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 2);
		this.getContainer().getActor().updateRageVisuals(this.m.RageStacks);
	}

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.addRage(1);
	}

	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		this.addRage(3);
	}
});