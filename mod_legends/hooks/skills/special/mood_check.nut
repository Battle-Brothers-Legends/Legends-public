::mods_hookExactClass("skills/special/mood_check", function(o)
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties ) {
		onUpdate(_properties);
		local actor = this.getContainer().getActor();
		if (actor.m.MoraleState == this.Const.MoraleState.Ignore) {
			this.m.IsHidden = true;
			return;
		}
	}

	local onCombatStarted = o.onCombatStarted;
	o.onCombatStarted = function () {
		local actor = this.getContainer().getActor();
		if (actor.m.MoraleState == this.Const.MoraleState.Ignore)
			return;
		onCombatStarted();
	}
});
