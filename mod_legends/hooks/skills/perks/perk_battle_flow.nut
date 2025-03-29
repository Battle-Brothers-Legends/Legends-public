::mods_hookExactClass("skills/perks/perk_battle_flow", function(o) {
	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		if (!this.m.IsSpent)
		{
			this.m.IsSpent = true;
			local actor = this.getContainer().getActor();
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - actor.getBaseProperties().Stamina * actor.getBaseProperties().StaminaMult * 0.1));
			actor.setDirty(true);
		}
	}
});